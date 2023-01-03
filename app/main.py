import asyncio
from typing import Optional

import uvloop
from fastapi import FastAPI, APIRouter

from app.infra.database import Database
from settings.config import get_settings
from settings.enviroments.base import AppSettings


class Application:
    def __init__(self, settings: AppSettings, database: Database):
        self.app = FastAPI(
            title="Hack API",
            description="Python API to train in DDD",
            debug=settings.DEBUG,
            openapi_url=settings.OPENAPI_URL,
            servers=[
                {"url": settings.OPENAPI_FETCHING_SERVER},
            ],
        )
        self.app.state.config = settings
        self.app.state.database = database
        self.configure_hooks()

    @property
    def fastapi_app(self) -> FastAPI:
        return self.app

    def configure_hooks(self) -> None:
        self.app.add_event_handler("startup", self.connect_database)
        self.app.add_event_handler("shutdown", self.disconnect_database)

    async def connect_database(self) -> None:
        await self.app.state.database.create_tables()

    async def disconnect_database(self) -> None:
        await self.app.state.database.disconnect()
