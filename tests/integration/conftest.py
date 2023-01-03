import asyncio
import os
from typing import AsyncGenerator, Generator

import pytest
import structlog
from asgi_lifespan import LifespanManager
from dotenv import load_dotenv
from fastapi import FastAPI
from httpx import AsyncClient
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, Session
from sqlalchemy_utils import drop_database, database_exists, create_database

from app.infra.database import DBBase
from settings.enviroments.base import AppSettings
from tests.base_factories import TestDBSession

logger = structlog.get_logger()


def load_env() -> None:
    is_local_test = "LOCALTEST" in os.environ
    test_environment_path = "settings/.env.local.runtests" if is_local_test else "settings/.env.ci.runtests"
    load_dotenv(test_environment_path, override=is_local_test)


load_env()


@pytest.fixture(scope="session")
def anyio_backend():
    return "asyncio"


@pytest.fixture(scope="session", autouse=True)
def event_loop() -> Generator[asyncio.AbstractEventLoop, None, None]:
    """Fixes error:
    ```ScopeMismatch: You tried to access the 'function' scoped fixture 'event_loop'
    with a 'session' scoped request object, involved factories```

    Also fixes error with unclosed loop in unit tests

    "https://github.com/pytest-dev/pytest-asyncio/issues/30#issuecomment-226947196"
    """
    loop = asyncio.get_event_loop_policy().new_event_loop()
    asyncio.set_event_loop(loop)

    yield loop


@pytest.fixture(scope="session")
def test_settings(worker_id: int) -> AppSettings:
    from settings.config import get_settings
    settings = get_settings(db_name=f'hack_api_test_{worker_id}')
    return settings


@pytest.fixture(scope="session")
async def app(test_settings: AppSettings,
              sync_db_session: Session) -> AsyncGenerator[FastAPI, None]:
    from app.api.main import create_api_app
    app = create_api_app(settings=test_settings)
    async with LifespanManager(app, startup_timeout=20):
        yield app


@pytest.fixture()
async def rest_client(
    app: FastAPI,
) -> AsyncGenerator[AsyncClient, None]:
    """
    Default http client. Use to test unauthorized requests, public endpoints
    or special authorization methods.
    """
    async with AsyncClient(
        app=app,
        base_url="http://test",
        headers={"Content-Type": "application/json"},
    ) as client:
        yield client


@pytest.fixture()
def sync_db(sync_db_session: Session) -> Generator[Session, None, None]:
    yield sync_db_session
    _clear_tables(sync_db_session)


@pytest.fixture(scope="session")
def sync_db_session(request: pytest.FixtureRequest, test_settings: AppSettings) -> scoped_session:
    """
    1. Создаем тестовую базу (CREATE DATABASE)
    2. Создаем Engine, в котором хранится connection pool для доступа к этой базе
    3. Создаем все таблицы, которые в базе должны храниться (множество таблиц берется из metadata объекта ConcreteBase)
    3. На всю pytest сессию создается 1 connection к базе.
    4. Прикрепляем созданную ранее 1 сессию алхимии (см factories.DBLSession например) к коннекшну из пункта 3
    5. Прикрепляем созданную ранее 1 сессию алхимии к FactoryBoy -
       Теперь все фабрики FactoryBoy при создании будут использовать одну и ту же сессию в рамках одной базы
    6. После прогона каждого теста чистим все таблицы, которые изменили в рамках теста (см _clear_tables)
    7. После прогона всех тестов удаляем сессию и закрываем connection
    """
    db_sync_dsn = test_settings.SYNC_DB_SQLALCHEMY_URI
    print('--session--')
    print(test_settings.SYNC_DB_SQLALCHEMY_URI)
    if 'test' not in db_sync_dsn.database:
        message = "dsn for database `{db}` not ending on test. probably real db on host {host}".format(
            db=test_settings.DB_NAME,
            host=test_settings.DB_HOST,
        )
        pytest.exit(message)

    if database_exists(db_sync_dsn):
        logger.warning(
            "test database {db} already exists on host {host}, dropping it",
            db=test_settings.DB_NAME,
            host=test_settings.DB_HOST,
        )
        drop_database(db_sync_dsn)
    create_database(db_sync_dsn)
    sync_engine = create_engine(
        db_sync_dsn,
        echo=False,
        pool_pre_ping=True,
    )
    DBBase.metadata.create_all(sync_engine)

    connection = sync_engine.connect()
    # http://factoryboy.readthedocs.io/en/latest/orms.html#managing-sessions
    TestDBSession.configure(bind=connection, autocommit=True)

    def teardown() -> None:
        DBBase.metadata.drop_all(bind=sync_engine)
        logger.info(
            "dropping test database {db} host {host}",
            db=test_settings.DB_NAME,
            host=test_settings.DB_HOST,
        )
        TestDBSession.close()
        connection.close()

    request.addfinalizer(teardown)

    return TestDBSession


def _clear_tables(sync_session: Session) -> None:
    with sync_session.connection() as connection:
        connection.execute("SET session_replication_role = replica;")
        for tbl in DBBase.metadata.sorted_tables:
            connection.execute(tbl.delete())
        connection.execute("SET session_replication_role = DEFAULT;")
    # clears session identity map, so that it doesn't have deleted objects in memory
    sync_session.expunge_all()
    sync_session.expire_all()
