from typing import Literal

from pydantic import SecretStr

from settings.enviroments.base import AppSettings, LogLevelEnum, LogTypeEnum, StageEnum


class DevAppSettings(AppSettings):
    STAGE: Literal[StageEnum.dev]
    DB_NAME: str = "hack_api"

    DEBUG = True

    class Config:
        env_file: str = "settings/.env"
