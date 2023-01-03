import enum

from pydantic.dataclasses import dataclass

from app.core.shared.domain import EntityId, Name
from app.core.shared.mixins import DisplayValuesMixin


class Species(str, DisplayValuesMixin, enum.Enum):
    human = 'human'
    alien = 'alien'
    humanoid = 'humanoid'
    animal = 'animal'
    parasite = 'parasite'
    cronenberg = 'cronenberg'
    disease = 'disease'
    robot = 'robot'
    unknown = 'unknown'
    mytholog = 'mytholog'
    vampire = 'vampire'


class Status(str, DisplayValuesMixin, enum.Enum):
    alive = 'alive'
    dead = 'dead'
    unknown = 'unknown'


@dataclass(config=dict(arbitrary_types_allowed=True))
class ShortCharacter:
    id: EntityId
    name: Name
    species: Species
    status: Status
