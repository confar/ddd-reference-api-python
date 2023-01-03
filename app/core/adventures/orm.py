from sqlalchemy import Column, VARCHAR, INTEGER, Integer, ForeignKey, VARCHAR
from sqlalchemy.dialects.postgresql import TIMESTAMP
from sqlalchemy.orm import relationship

from app.core.adventures.domain import Adventure
from app.core.adventures.shared.domain import ShortAdventure
from app.core.shared.domain import Name, EntityId
from app.infra.database import DBBase


class AdventureParticipantORM(DBBase):
    __tablename__ = "adventure_participants"

    id = Column(Integer, primary_key=True)
    participant_id = Column(Integer, ForeignKey('characters.id'))
    adventure_id = Column(Integer, ForeignKey('adventures.id'))

    @classmethod
    def from_domain(cls, adventure: Adventure) -> list['AdventureParticipantORM']:
        return [cls(adventure_id=adventure.id.value,
                    participant_id=participant.id.value) for participant in adventure.participants]


class AdventureORM(DBBase):
    __tablename__ = "adventures"

    id = Column(INTEGER(), autoincrement=True, primary_key=True)
    name = Column(VARCHAR(length=255), nullable=False)
    location_id = Column(Integer, ForeignKey('locations.id'))
    started_at = Column(TIMESTAMP)
    active_till = Column(TIMESTAMP)
    participants = relationship('CharacterORM', secondary='adventure_participants',
                                lazy="raise",
                                back_populates='adventures')
    location = relationship("LocationORM", lazy="raise", back_populates="adventures", uselist=False,
                            primaryjoin="LocationORM.id==AdventureORM.location_id")

    def __str__(self):
        return f'Adventure(id={self.id}, name={self.name}, ' \
               f'season={self.season}, adventure={self.adventure_number})'

    @classmethod
    def from_domain(cls, adventure: Adventure) -> 'AdventureORM':
        return cls(id=adventure.id.value,
                   name=adventure.name.value,
                   location_id=adventure.location.id.value,
                   started_at=adventure.started_at,
                   active_till=adventure.active_till)

    def to_domain_adventure(self) -> Adventure:
        return Adventure(id=EntityId(self.id),
                         name=Name(self.name),
                         started_at=self.started_at,
                         location=self.location.to_short_location(),
                         active_till=self.active_till,
                         participants=[participant.to_domain_short_character() for participant in self.participants])

    def to_domain_short_adventure(self) -> ShortAdventure:
        return ShortAdventure(id=EntityId(self.id),
                              name=Name(self.name),
                              location=self.location.to_short_location(),
                              started_at=self.started_at,
                              active_till=self.active_till)