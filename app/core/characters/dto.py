from datetime import datetime

from pydantic import BaseModel, HttpUrl

from app.core.characters.domain import Status, Gender, Species, Character
from app.core.locations.shared.dto import ShortLocationDTO


class CharacterDTO(BaseModel):
    id: int
    name: str
    status: Status
    gender: Gender
    species: Species
    origin_location: ShortLocationDTO | None
    current_location: ShortLocationDTO
    type: str
    image_url: HttpUrl | None

    @classmethod
    def from_domain(cls, character: Character):
        return cls(id=character.id.value,
                   name=character.name.value,
                   status=character.status,
                   gender=character.gender,
                   species=character.species,
                   type=character.type.name,
                   image_url=character.image_url.url,
                   origin_location=ShortLocationDTO.from_domain(character.origin_location) if character.origin_location else None,
                   current_location=ShortLocationDTO.from_domain(character.current_location)
                  )