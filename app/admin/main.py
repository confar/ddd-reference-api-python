from typing import Optional

from fastapi import FastAPI
from sqladmin import Admin

from app.admin.adventures.admin import AdventureAdmin
from app.admin.characters.admin import CharacterAdmin
from app.admin.episodes.admin import EpisodeAdmin
from app.admin.locations.admin import LocationAdmin
from app.infra.database import Database
from app.main import Application
from settings.config import get_settings
from settings.enviroments.base import AppSettings


def create_admin_app(settings: Optional[AppSettings] = None) -> FastAPI:
    settings = settings or get_settings()

    database = Database(db_connect_url=settings.DB_SQLALCHEMY_URI,
                        pool_size=settings.DB_POOL_SIZE)
    app = Application(settings=settings, database=database).fastapi_app

    admin = Admin(app, engine=database._engine)
    admin.add_view(CharacterAdmin)
    admin.add_view(LocationAdmin)
    admin.add_view(EpisodeAdmin)
    admin.add_view(AdventureAdmin)


if __name__ == '__main__':
    import uvicorn
    app = create_admin_app()
    host = app.state.config.APP_HOST
    port = app.state.config.APP_PORT
    uvicorn.run(app, port=port, host=host)