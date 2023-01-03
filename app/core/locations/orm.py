from sqlalchemy import Enum, Column, VARCHAR, INTEGER, VARCHAR
from sqlalchemy.dialects.postgresql import TIMESTAMP
from sqlalchemy.orm import relationship

from app.core.adventures.orm import AdventureORM
from app.core.characters.orm import CharacterORM
from app.core.locations.shared.domain import ShortLocation
from app.core.shared.domain import Name, EntityId
from app.core.locations.domain import Dimension, LocationType, Location
from app.infra.database import DBBase


class LocationORM(DBBase):
    __tablename__ = "locations"

    id = Column(INTEGER(), autoincrement=True, primary_key=True)
    name = Column(VARCHAR(length=255), nullable=False)
    dimension = Column(Enum(Dimension), default=Dimension.unknown, nullable=False)
    created_at = Column(TIMESTAMP, nullable=True)
    type = Column(Enum(LocationType), default=LocationType.unknown, nullable=False)
    residents = relationship(CharacterORM, lazy="raise", back_populates="current_location", uselist=True,
                             primaryjoin="LocationORM.id==CharacterORM.current_location_id")
    originated_characters = relationship(CharacterORM, lazy="raise", back_populates="origin_location", uselist=True,
                                         primaryjoin="LocationORM.id==CharacterORM.origin_location_id")

    adventures = relationship(AdventureORM, lazy="raise", back_populates="location", uselist=True,
                              primaryjoin="LocationORM.id==AdventureORM.location_id")

    def __str__(self):
        return f'Location(id={self.id}, name={self.name}, dimension={self.dimension.value}, type={self.type.value})'

    def to_location(self) -> Location:
        return Location(id=EntityId(self.id),
                        name=Name(self.name),
                        type=self.type,
                        dimension=self.dimension,
                        created_at=self.created_at,
                        residents=[resident.to_domain_short_character() for resident in self.residents])

    def to_short_location(self) -> ShortLocation:
        return ShortLocation(id=EntityId(self.id),
                             name=Name(self.name),
                             dimension=self.dimension)
