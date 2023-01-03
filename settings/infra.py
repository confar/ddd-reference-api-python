"""Компоненты настроек инфраструктуры вокруг приложения."""
from typing import Any, Optional

from pydantic import BaseSettings, validator, SecretStr
from sqlalchemy.engine import URL


class OpenAPISettings(BaseSettings):
    OPENAPI_URL: str = "/openapi.json"
    OPENAPI_FETCHING_SERVER: str = "/"


class RedisSettings(BaseSettings):
    REDIS_HOST: str = '0.0.0.0'
    REDIS_PORT: int = 7000


class DBSettings(BaseSettings):
    SYNC_DRIVER_NAME: str = "postgresql+psycopg2"
    ASYNC_DRIVER_NAME: str = "postgresql+asyncpg"

    DB_HOST: str = "localhost"
    DB_PORT: str = "5432"
    DB_NAME: str
    DB_USER: str = "hack_api_user"
    DB_PASSWORD: SecretStr = "password"
    DB_POOL_SIZE: int = 5

    DB_SQLALCHEMY_URI: URL = None
    SYNC_DB_SQLALCHEMY_URI: URL = None

    @staticmethod
    def _make_db_uri(
        value: Optional[str], values: dict[str, Any], for_sync: bool = False
    ) -> URL:
        """
        Возвращает uri для заданной базы
        Args:
            value: Optional[str] - значение, переданное в валидируемое поле
            values: Dict[str, Any] - словарь значений переданных в модель

        Returns:
            str - uri для заданного шарда dbp
        """
        if isinstance(value, str):
            raise ValueError("Its autobuild value")
        if for_sync:
            driver = values['SYNC_DRIVER_NAME']
        else:
            driver = values['ASYNC_DRIVER_NAME']
        url = URL.create(
            drivername=driver,
            database=values.get(f"DB_NAME"),
            username=values.get(f"DB_USER"),
            password=values.get(f"DB_PASSWORD"),
            host=values.get(f"DB_HOST"),
            port=values.get(f"DB_PORT"),
        )
        return url

    @validator("DB_SQLALCHEMY_URI", pre=True)
    def db_dsn(cls, value: Optional[str], values: dict[str, Any]) -> URL:
        return cls._make_db_uri(value=value, values=values)

    @validator("SYNC_DB_SQLALCHEMY_URI", pre=True)
    def sync_db_dsn(cls, value: Optional[str], values: dict[str, Any]) -> URL:
        return cls._make_db_uri(value=value, values=values, for_sync=True)

