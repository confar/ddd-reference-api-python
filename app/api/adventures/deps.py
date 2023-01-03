from fastapi import Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session

from app.api.base_deps import get_db_session
from app.api.characters.deps import get_character_service
from app.api.locations.deps import get_location_service
from app.core.adventures.repositories import AdventureRepository
from app.core.adventures.services import AdventureService
from app.core.characters.services import CharacterService
from app.core.locations.services import LocationService



def get_adventure_repository(
    session: AsyncSession = Depends(get_db_session),
) -> AdventureRepository:
    return AdventureRepository(session=session)


def get_adventure_service(
    repository: AdventureRepository = Depends(get_adventure_repository),
    location_service: LocationService = Depends(get_location_service),
    character_service: CharacterService = Depends(get_character_service),
) -> AdventureService:
    return AdventureService(repository=repository,
                            location_service=location_service,
                            character_service=character_service)
