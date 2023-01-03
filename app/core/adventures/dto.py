from datetime import datetime, date

from pydantic import BaseModel

from app.core.adventures.domain import Adventure
from app.core.characters.shared.dto import ShortCharacterDTO
from app.core.locations.shared.dto import ShortLocationDTO


class AdventureDTO(BaseModel):
    id: int
    name: str
    started_at: datetime
    active_till: datetime
    location: ShortLocationDTO
    participants: list[ShortCharacterDTO]

    @classmethod
    def from_domain(cls, adventure: Adventure) -> "AdventureDTO":
        return cls(id=adventure.id.value,
                   name=adventure.name.value,
                   started_at=adventure.started_at,
                   active_till=adventure.active_till,
                   location=ShortLocationDTO.from_domain(adventure.location),
                   participants=[ShortCharacterDTO.from_domain(character) for character in adventure.participants])
