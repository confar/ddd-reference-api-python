from fastapi import Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session

from app.api.base_deps import get_db_session
from app.core.locations.repositories import LocationRepository, LocationCSVRepository
from app.core.locations.services import LocationService


def get_location_repository(
    session: AsyncSession = Depends(get_db_session),
) -> LocationRepository:
    return LocationRepository(session=session)

def get_location_csv_repository(
) -> LocationCSVRepository:
    return LocationCSVRepository()


def get_location_service(
    repository: LocationRepository = Depends(get_location_repository),
    csv_repository: LocationCSVRepository = Depends(get_location_csv_repository),
) -> LocationService:
    return LocationService(repository=repository, csv_repository=csv_repository)