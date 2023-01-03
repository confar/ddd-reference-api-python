from sqlalchemy import Column, VARCHAR, INTEGER, Integer, ForeignKey, DATE, VARCHAR
from sqlalchemy.orm import relationship

from app.core.episodes.domain import Episode, EpisodeSequence
from app.core.shared.domain import Name, EntityId
from app.infra.database import DBBase


class EpisodeCharacterORM(DBBase):
    __tablename__ = "episode_characters"

    id = Column(Integer, primary_key=True)
    character_id = Column(Integer, ForeignKey('characters.id'))
    episode_id = Column(Integer, ForeignKey('episodes.id'))


class EpisodeORM(DBBase):
    __tablename__ = "episodes"

    id = Column(INTEGER(), autoincrement=True, primary_key=True)
    name = Column(VARCHAR(length=255), nullable=False)
    air_date = Column(DATE, nullable=True)
    season = Column(INTEGER())
    episode_number = Column(INTEGER())
    characters = relationship('CharacterORM', secondary=EpisodeCharacterORM.__tablename__,
                              lazy="raise",
                              back_populates='episodes')

    def __str__(self):
        return f'Episode(id={self.id}, name={self.name}, ' \
               f'season={self.season}, episode={self.episode_number})'

    def get_episode_sequence(self) -> EpisodeSequence:
        season = str(self.season)
        episode_number = str(self.episode_number)
        return EpisodeSequence(f'S{season.zfill(2)}E{episode_number.zfill(2)}')

    def to_domain_episode(self) -> Episode:
        return Episode(id=EntityId(self.id),
                       name=Name(self.name),
                       air_date=self.air_date,
                       episode_sequence=self.get_episode_sequence(),
                       characters=[character.to_domain_short_character() for character in self.characters])
