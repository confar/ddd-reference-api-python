from rodi import Container, GetServiceContext
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.adventures.repositories import AdventureRepository
from app.core.adventures.services import AdventureService
from app.core.characters.repositories import CharacterRepository, CharacterCSVRepository
from app.core.characters.services import CharacterService
from app.core.episodes.repositories import EpisodeRepository, EpisodeCSVRepository
from app.core.episodes.services import EpisodeService
from app.core.locations.repositories import LocationRepository, LocationCSVRepository
from app.core.locations.services import LocationService
from app.infra.database import Database
from settings.config import get_settings
from settings.enviroments.base import AppSettings


def settings_factory() -> AppSettings:
    return get_settings()


def get_db(context: GetServiceContext) -> Database:
    settings = context.provider.get(AppSettings)
    return Database(db_connect_url=settings.DB_SQLALCHEMY_URI,
                    pool_size=settings.DB_POOL_SIZE)


def session_factory(context: GetServiceContext) -> AsyncSession:
    database = context.provider.get(Database)
    return database._async_session_factory()

container = Container()
container.add_scoped_by_factory(factory=settings_factory)
container.add_singleton_by_factory(factory=get_db)
container.add_scoped_by_factory(factory=session_factory)

container.add_transient(LocationService)
container.add_transient(LocationRepository)
container.add_transient(LocationCSVRepository)

container.add_transient(CharacterService)
container.add_transient(CharacterCSVRepository)
container.add_transient(CharacterRepository)

container.add_transient(EpisodeService)
container.add_transient(EpisodeRepository)
container.add_transient(EpisodeCSVRepository)

container.add_transient(AdventureService)
container.add_transient(AdventureRepository)

deps_provider = container.build_provider()
