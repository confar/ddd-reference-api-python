import asyncio
from typing import Optional

import uvloop
from fastapi import FastAPI, APIRouter

from app.api.characters.controllers import router as character_router
from app.api.locations.controllers import router as location_router
from app.api.episodes.controllers import router as episode_router
from app.api.adventures.controllers import router as adventure_router
from app.api.system.controllers import router as system_router
from app.infra.database import Database
from app.main import Application
from settings.config import get_settings
from settings.enviroments.base import AppSettings

api_router = APIRouter()
api_router.include_router(character_router)
api_router.include_router(location_router)
api_router.include_router(episode_router)
api_router.include_router(adventure_router)
api_router.include_router(system_router)

asyncio.set_event_loop_policy(uvloop.EventLoopPolicy())


def create_api_app(settings: Optional[AppSettings] = None) -> FastAPI:
    settings = settings or get_settings()

    database = Database(db_connect_url=settings.DB_SQLALCHEMY_URI,
                        pool_size=settings.DB_POOL_SIZE)
    app = Application(settings=settings, database=database).fastapi_app

    app.include_router(api_router, prefix="/api")
    return app


if __name__ == '__main__':
    import uvicorn
    app = create_api_app()
    host = app.state.config.APP_HOST
    port = app.state.config.APP_PORT
    uvicorn.run(app, port=port, host=host)
