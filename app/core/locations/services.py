import csv
import math
from datetime import datetime

from Levenshtein import distance

from app.core.locations.orm import LocationORM
from app.core.locations.shared.domain import ShortLocation
from app.core.shared.domain import EntityId
from app.core.locations.domain import Dimension, LocationType, Location
from app.core.locations.repositories import LocationRepository, LocationCSVRepository
from app.core.shared.pagination import LimitOffsetPagination


class LocationService:
    def __init__(self, repository: LocationRepository,
                 csv_repository: LocationCSVRepository):
        self._repository = repository
        self._csv_repository = csv_repository

    async def get_locations_page(self, pagination: LimitOffsetPagination) -> list[Location]:
        return await self._repository.get_locations_page(pagination)

    async def get_location_by(self, id: EntityId) -> Location:
        return await self._repository.get_location_by(id)

    async def get_short_location_by(self, id: EntityId) -> ShortLocation:
        return await self._repository.get_short_location_by(id)

    async def move_location_to_another_dimension(self, id: EntityId,  target_dimension: Dimension) -> Location:
        location = await self._repository.get_location_by(id)
        location.move_to_another_dimension(target_dimension)
        await self._repository.save_new_dimension(location)
        return location

    async def populate_data_from_csv(self):
        locations = self._csv_repository.get_locations()
        await self._repository.populate_data_from_csv(locations)
