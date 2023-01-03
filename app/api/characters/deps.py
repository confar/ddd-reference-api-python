from fastapi import Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.base_deps import get_db_session
from app.api.locations.deps import get_location_service
from app.core.characters.repositories import CharacterRepository, CharacterCSVRepository
from app.core.characters.services import CharacterService
from app.core.locations.services import LocationService


def get_character_repository(
    session: AsyncSession = Depends(get_db_session),
) -> CharacterRepository:
    return CharacterRepository(session=session)


def get_character_csv_repository(
) -> CharacterCSVRepository:
    return CharacterCSVRepository()


def get_character_service(
    repository: CharacterRepository = Depends(get_character_repository),
    csv_repository: CharacterCSVRepository = Depends(get_character_csv_repository),
    location_service: LocationService = Depends(get_location_service),
) -> CharacterService:
    return CharacterService(repository=repository,
                            location_service=location_service,
                            csv_repository=csv_repository)
