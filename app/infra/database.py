import structlog
from sqlalchemy import orm
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, AsyncEngine
from sqlalchemy.orm import declarative_base

logger = structlog.get_logger()

DBBase = declarative_base()


class Database:
    def __init__(
        self,
        db_connect_url: str,
        pool_size: int,
        echo_logs: bool = False,
    ) -> None:

        self._engine: AsyncEngine = create_async_engine(
            url=db_connect_url,
            max_overflow=10,
            pool_pre_ping=True,
            pool_size=pool_size,
            echo=echo_logs,
            echo_pool=echo_logs,
        )

        self._async_session_factory = orm.sessionmaker(
            autocommit=False,
            autoflush=False,
            class_=AsyncSession,
            expire_on_commit=False,
            bind=self._engine,
        )

    async def create_tables(self) -> None:
        async with self._engine.begin() as conn:
            await conn.run_sync(DBBase.metadata.create_all)

    async def disconnect(self) -> None:
        logger.info("closing database connections for db")
        try:
            await self._engine.dispose()
        except Exception as exc:
            logger.warning("failed to close database connections due to {}", exc)
        else:
            logger.info("database connections closed for db")
