from typing import Literal, Optional

from settings.enviroments.base import AppSettings, StageEnum


class ProdAppSettings(AppSettings):
    STAGE: Literal[StageEnum.production]

    class Config:
        env_file: Optional[str] = None
