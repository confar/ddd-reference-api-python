import csv
from datetime import datetime

from sqlalchemy import select, update
from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session, joinedload

from app.core.shared.domain import EntityId
from app.core.episodes.domain import Episode
from app.core.episodes.orm import EpisodeORM, EpisodeCharacterORM
from app.core.shared.pagination import LimitOffsetPagination


class EpisodeCSVRepository:
    EPISODE_CSV_PATH = './app/core/episodes/data/episodes.csv'
    EPISODE_CHARACTERS_CSV_PATH = './app/core/episodes/data/episode_characters.csv'

    def get_episodes(self) -> list[EpisodeORM]:
        episodes = []
        with open(self.EPISODE_CSV_PATH) as file:
            episodes_rows = csv.DictReader(file, delimiter=',')
            for row in episodes_rows:
                episodes.append(EpisodeORM(id=int(row['id']),
                                           name=row['name'],
                                           season=int(row['season']),
                                           episode_number=int(row['episode_number']),
                                           air_date=datetime.strptime(row['air_date'], '%Y-%m-%d')))
        return episodes

    def get_episode_characters(self) -> list[EpisodeCharacterORM]:
        episode_characters = []
        with open(self.EPISODE_CHARACTERS_CSV_PATH) as file:
            episode_characters_rows = csv.DictReader(file, delimiter=',')
            for row in episode_characters_rows:
                episode_characters.append(EpisodeCharacterORM(episode_id=int(row['episode_id']),
                                                              character_id=int(row['character_id'])))
        return episode_characters



class EpisodeRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_episodes_page(self, pagination: LimitOffsetPagination) -> list[Episode]:
        query = (select(EpisodeORM)
                 .options(joinedload(EpisodeORM.characters, innerjoin=False))
                 .limit(pagination.limit).offset(pagination.offset))
        result = await self.session.execute(query)
        episodes_orm = result.unique().scalars().all()
        episodes = []
        for episode_orm in episodes_orm:
            episodes.append(episode_orm.to_domain_episode())
        return episodes

    async def get_episode_by(self, id: EntityId) -> Episode:
        query = (select(EpisodeORM)
                 .options(joinedload(EpisodeORM.characters, innerjoin=False)
        ).where(EpisodeORM.id == id.value))
        result = await self.session.execute(query)
        return result.unique().scalar_one().to_domain_episode()

    async def populate_episodes_data_from_csv(self, episodes: list[EpisodeORM]) -> None:
        self.session.add_all(episodes)
        await self.session.flush()
        await self.session.commit()

    async def populate_episode_characters_data_from_csv(self, episode_characters: list[EpisodeCharacterORM]) -> None:
        self.session.add_all(episode_characters)
        await self.session.flush()
        await self.session.commit()
