from datetime import datetime

from pydantic import BaseModel

from app.core.characters.shared.dto import ShortCharacterDTO
from app.core.locations.domain import Dimension, Location

class LocationCsvDTO(BaseModel):
    id: int
    name: str
    type: str
    dimension: Dimension
    created_at: datetime


class LocationDTO(BaseModel):
    id: int
    name: str
    dimension: Dimension
    created_at: datetime
    residents: list[ShortCharacterDTO]

    @classmethod
    def from_domain(cls, location: Location) -> "LocationDTO":
        return cls(id=location.id.value,
                   name=location.name.value,
                   type=location.type.name,
                   created_at=location.created_at,
                   dimension=location.dimension,
                   residents=[ShortCharacterDTO.from_domain(resident) for resident in location.residents])
