from sqlalchemy import Column, INTEGER, VARCHAR, Text, ForeignKey, VARCHAR
from sqlalchemy.dialects.postgresql import ENUM, TIMESTAMP
from sqlalchemy.orm import relationship

from app.core.characters.domain import CharacterType, Gender, Species, Status, Character, ImageUrl
from app.core.characters.shared.domain import ShortCharacter
from app.core.episodes.orm import EpisodeCharacterORM
from app.core.shared.domain import EntityId, Name
from app.infra.database import DBBase


class CharacterORM(DBBase):
    __tablename__ = "characters"

    id = Column(INTEGER(), autoincrement=True, primary_key=True)
    name = Column(VARCHAR(length=255), nullable=False)
    status = Column(ENUM(Status), default=Status.unknown, nullable=False)
    type = Column(VARCHAR(length=255), nullable=False)
    species = Column(ENUM(Species), default=Species.human, nullable=False)
    gender = Column(ENUM(Gender), default=Gender.unknown, nullable=False)
    image_url = Column(Text(), nullable=True)
    created_at = Column(TIMESTAMP, nullable=True)
    origin_location_id = Column(ForeignKey("locations.id", ondelete="CASCADE"), nullable=True)
    current_location_id = Column(ForeignKey("locations.id", ondelete="CASCADE"), nullable=True)

    origin_location = relationship("LocationORM", lazy="raise", back_populates="originated_characters", uselist=False,
                                   primaryjoin="LocationORM.id==CharacterORM.origin_location_id")
    current_location = relationship("LocationORM", lazy="raise", back_populates="residents", uselist=False,
                                    primaryjoin="LocationORM.id==CharacterORM.current_location_id")

    episodes = relationship('EpisodeORM', secondary=EpisodeCharacterORM.__tablename__,
                            lazy="raise",
                            back_populates='characters')
    adventures = relationship('AdventureORM', secondary='adventure_participants',
                             lazy="raise",
                             back_populates='participants')

    def __str__(self):
        return f'Character(id={self.id}, name={self.name}, species={self.species.value})'

    def to_domain(self):
        return Character(id=EntityId(self.id),
                         name=Name(self.name),
                         status=self.status,
                         gender=self.gender,
                         species=self.species,
                         created_at=self.created_at,
                         type=CharacterType(self.type),
                         image_url=ImageUrl(self.image_url),
                         current_location=self.current_location.to_short_location(),
                         origin_location=self.origin_location.to_short_location() if self.origin_location else None)

    def to_domain_short_character(self) -> ShortCharacter:
        return ShortCharacter(id=EntityId(self.id),
                              name=Name(self.name),
                              species=self.species,
                              status=self.status)