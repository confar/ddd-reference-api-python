from typing import Literal

from settings.enviroments.base import AppSettings, StageEnum


class CITestAppSettings(AppSettings):
    STAGE: Literal[StageEnum.ci_runtests]

    DB_NAME: str = "hack_api_test"
    DB_PORT: str = "6432"
