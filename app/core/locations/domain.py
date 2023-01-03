import enum
from datetime import datetime

from pydantic.dataclasses import dataclass

from app.core.characters.shared.domain import ShortCharacter
from app.core.locations.exceptions import AlreadyThereError
from app.core.locations.shared.domain import Dimension
from app.core.shared.domain import EntityId, Name
from app.core.shared.mixins import DisplayValuesMixin


class LocationType(str, DisplayValuesMixin, enum.Enum):
    unknown = 'unknown'
    planet = 'planet'
    cluster = 'cluster'
    microverse = 'microverse'
    teenyverse = 'teenyverse'
    miniverse = 'miniverse'
    space_station = 'space_station'
    tv = 'tv'
    resort = 'resort'
    fantasy_town = 'fantasy_town'
    dream = 'dream'
    menagerie = 'menagerie'
    game = 'game'
    celestial_dwarf = 'celestial_dwarf'
    spacecraft = 'celestial_dwarf'


@dataclass(config=dict(arbitrary_types_allowed=True))
class Location:
    id: EntityId
    name: Name
    dimension: Dimension
    type: LocationType
    created_at: datetime
    residents: list[ShortCharacter]

    def __init__(self,
                 id: EntityId,
                 name: Name,
                 type: LocationType,
                 dimension: Dimension,
                 residents: list[ShortCharacter],
                 created_at: datetime = datetime.now()):
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.created_at = created_at
        self.residents = residents
        self.added_residents = []

    def move_to_another_dimension(self, target_dimension: Dimension):
        if self.dimension == target_dimension:
            raise AlreadyThereError()
        self.dimension = target_dimension
