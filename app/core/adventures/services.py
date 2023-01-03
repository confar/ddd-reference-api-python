import csv
import datetime

from app.core.adventures.domain import Adventure
from app.core.characters.services import CharacterService
from app.core.locations.domain import Location
from app.core.locations.services import LocationService
from app.core.shared.domain import EntityId, Name
from app.core.adventures.dto import AdventureDTO
from app.core.adventures.repositories import AdventureRepository
from app.core.shared.pagination import LimitOffsetPagination


class AdventureService:
    def __init__(self, repository: AdventureRepository,
                 location_service: LocationService,
                 character_service: CharacterService,
                 ):
        self._repository = repository
        self.location_service = location_service
        self.character_service = character_service

    async def get_active_adventures_page(self) -> list[Adventure]:
        return await self._repository.get_active_adventures()

    async def get_adventure_by(self, id: EntityId) -> Adventure:
        return await self._repository.get_adventure_by(id)

    async def go_on_adventure_with(self,
                                   adventure_name: str,
                                   duration_minutes: int,
                                   participant_ids: list[EntityId],
                                   location_id: EntityId) -> Adventure:
        location = await self.location_service.get_short_location_by(location_id)
        participants = await self.character_service.get_all_characters_by(participant_ids)
        name = Name(adventure_name)
        adventure_id = await self._repository.get_next_adventure_id()
        adventure = Adventure.build_new(id=adventure_id,
                                        name=name,
                                        location=location,
                                        duration_minutes=duration_minutes,
                                        participants=participants)
        await self._repository.arrange_aventure(adventure)
        return await self._repository.get_adventure_by(adventure.id)
