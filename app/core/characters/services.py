import asyncio
import csv
from datetime import datetime

import requests
from httpx import AsyncClient

from app.core.characters.domain import Species, Gender, Character
from app.core.characters.dto import CharacterDTO
from app.core.characters.orm import CharacterORM
from app.core.characters.repositories import CharacterRepository, CharacterCSVRepository
from app.core.characters.shared.domain import ShortCharacter
from app.core.shared.domain import EntityId
from app.core.locations.services import LocationService
from app.core.shared.pagination import LimitOffsetPagination
from bs4 import BeautifulSoup


class CharacterService:
    def __init__(self,
                 location_service: LocationService,
                 repository: CharacterRepository,
                 csv_repository: CharacterCSVRepository,
                 ):
        self.location_service = location_service
        self._repository = repository
        self._csv_repository = csv_repository

    async def get_characters_page(self, pagination: LimitOffsetPagination) -> list[Character]:
        return await self._repository.get_characters_page(pagination)

    async def get_character_by(self, id: EntityId) -> Character:
        return await self._repository.get_character_by(id)

    async def get_all_characters_by(self, ids: list[EntityId]) -> list[ShortCharacter]:
        return await self._repository.get_all_characters_by(ids)

    async def prepare_to_take_place(self, id: EntityId) -> Character:
        character = await self._repository.get_character_by(id)
        character.prepare_to_take_place()
        await self._repository.update_character_status(character)
        return character

    async def resurrect(self, id: EntityId) -> Character:
        character = await self._repository.get_character_by(id)
        character.resurrect()
        await self._repository.update_character_status(character)
        return character

    async def move_character_to(self,
                                character_id: EntityId,
                                target_location_id: EntityId) -> Character:
        character, location = await asyncio.gather(self._repository.get_character_by(character_id),
                                                   self.location_service.get_short_location_by(target_location_id))
        character.move_to(location)
        await self._repository.update_character_location(character)
        return character

    async def populate_data_from_csv(self):
        characters = self._csv_repository.get_characters()
        await self._repository.populate_data_from_csv(characters)
