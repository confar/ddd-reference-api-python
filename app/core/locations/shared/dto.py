from pydantic import BaseModel

from app.core.locations.shared.domain import Dimension, ShortLocation


class ShortLocationDTO(BaseModel):
    id: int
    name: str
    dimension: Dimension

    @classmethod
    def from_domain(cls, character_location: ShortLocation):
        return cls(id=character_location.id.value,
                   name=character_location.name.value,
                   dimension=character_location.dimension)