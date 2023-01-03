from typing import Dict, Type

from settings.enviroments.base import AppSettings, BaseAppSettings, StageEnum
from settings.enviroments.ci_runtests import CITestAppSettings
from settings.enviroments.dev import DevAppSettings
from settings.enviroments.production import ProdAppSettings
from settings.enviroments.dev_runtests import DevTestAppSettings

environments: Dict[str, Type[AppSettings]] = {
    StageEnum.ci_runtests: CITestAppSettings,
    StageEnum.dev: DevAppSettings,
    StageEnum.dev_runtests: DevTestAppSettings,
    StageEnum.production: ProdAppSettings,
}


def get_settings(db_name: str | None = None) -> AppSettings:
    app_env = BaseAppSettings().STAGE
    config = environments[app_env]
    if db_name:
        return config(DB_NAME=db_name)
    else:
        return config()
