"""Базовые настройки, которые необходимы для распознания окружения приложения."""
from enum import Enum

from pydantic import BaseSettings, SecretStr

from settings.infra import (
    DBSettings,
    OpenAPISettings,
    RedisSettings,
)


class LogTypeEnum(str, Enum):
    JSON = "json"
    PLAIN = "plain"


class StageEnum(str, Enum):
    production = "production"
    dev = "dev"
    dev_runtests = "dev_runtests"
    ci_runtests = "ci_runtests"


class LogLevelEnum(str, Enum):
    CRITICAL = "critical"
    ERROR = "error"
    WARNING = "warning"
    INFO = "info"
    DEBUG = "debug"
    NOTSET = ""


class BaseAppSettings(BaseSettings):
    STAGE: StageEnum

    class Config:
        env_file = "settings/.env"


class AppSettings(
    DBSettings,
    OpenAPISettings,
    RedisSettings,
    BaseAppSettings,
):
    PROJECT_NAME: str = "hack_api"
    STAGE: str
    LOCALTEST: bool = False
    DEBUG: bool = False

    APP_HOST: str = "0.0.0.0"
    APP_PORT: int = 5000
    LOG_LEVEL: LogLevelEnum = LogLevelEnum.DEBUG
    LOG_TYPE: LogTypeEnum = LogTypeEnum.PLAIN

    OPENAPI_URL: str = "/openapi.json"
    OPENAPI_FETCHING_SERVER: str = "/"

    DB_HOST: str = "localhost"
    DB_PORT: str = "5432"
    DB_NAME: str
    DB_USER: str = "hack_api_user"
    DB_PASSWORD: str = "mysqlpwd"
    DB_POOL_SIZE: int = 5

    class Config:
        case_sensitive = True
        allow_mutation = False

    @property
    def is_prod_environment(self) -> bool:
        return self.STAGE is StageEnum.production

    @property
    def is_test_environment(self) -> bool:
        return self.STAGE in {StageEnum.ci_runtests, StageEnum.dev_runtests}

    @property
    def is_json_logs_enabled(self) -> bool:
        return self.LOG_TYPE == LogTypeEnum.JSON

