from typing import Literal

from settings.enviroments.base import AppSettings, StageEnum


class DevTestAppSettings(AppSettings):
    STAGE: Literal[StageEnum.dev_runtests]

    DB_NAME: str = "hack_api_test"
    DB_PORT: str = "6432"

    class Config:
        allow_mutation = True

