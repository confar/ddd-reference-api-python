import csv
import datetime

from app.core.episodes.orm import EpisodeORM, EpisodeCharacterORM
from app.core.shared.domain import EntityId
from app.core.episodes.domain import EpisodeSequence, Episode
from app.core.episodes.dto import EpisodeDTO
from app.core.episodes.repositories import EpisodeRepository, EpisodeCSVRepository
from app.core.shared.pagination import LimitOffsetPagination


class EpisodeService:
    def __init__(self,
                 repository: EpisodeRepository,
                 csv_repository: EpisodeCSVRepository):
        self._repository = repository
        self._csv_repository = csv_repository

    async def get_episodes_page(self, pagination: LimitOffsetPagination) -> list[Episode]:
        return await self._repository.get_episodes_page(pagination)

    async def get_episode_by(self, id: EntityId) -> Episode:
        return await self._repository.get_episode_by(id)

    async def populate_data_from_csv(self):
        episodes = self._csv_repository.get_episodes()
        await self._repository.populate_episodes_data_from_csv(episodes)
        episode_characters = self._csv_repository.get_episode_characters()
        await self._repository.populate_episode_characters_data_from_csv(episode_characters)

