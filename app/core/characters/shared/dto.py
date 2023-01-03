from pydantic import BaseModel

from app.core.characters.shared.domain import Status, Species, ShortCharacter


class ShortCharacterDTO(BaseModel):
    id: int
    name: str
    species: Species
    status: Status

    @classmethod
    def from_domain(cls, short_character: ShortCharacter) -> "ShortCharacterDTO":
        return cls(id=short_character.id.value,
                   name=short_character.name.value,
                   species=short_character.species,
                   status=short_character.status)
