import enum
from datetime import datetime
from typing import Set, TYPE_CHECKING, Optional

from pydantic import HttpUrl
from pydantic.dataclasses import dataclass

from app.core.characters.exceptions import CharacterTypeError, InvalidStatusError, InvalidImageFormatError, \
    AlreadyHereError
from app.core.characters.shared.domain import Species, Status
from app.core.locations.domain import LocationType
from app.core.locations.shared.domain import ShortLocation
from app.core.shared.domain import Name, EntityId
from app.core.shared.mixins import DisplayValuesMixin



@dataclass(frozen=True)
class ImageUrl:
    url: HttpUrl | None

    def __post_init__(self):
        if self.url:
            if not self.url.endswith('png') and not self.url.endswith('jpg'):
                raise InvalidImageFormatError()


@dataclass
class CharacterType:
    name: str | None

    def __post_init__(self):
        if self.name and len(self.name) > 100:
            raise CharacterTypeError()
        if not self.name:
            self.name = ''


class Gender(str, DisplayValuesMixin, enum.Enum):
    male = 'male'
    female = 'female'
    unknown = 'unknown'


@dataclass(config=dict(arbitrary_types_allowed=True))
class Character:
    id: EntityId
    name: Name
    species: Species
    status: Status
    gender: Gender
    created_at: datetime
    type: CharacterType
    image_url: ImageUrl
    current_location: ShortLocation
    origin_location: Optional[ShortLocation]

    @classmethod
    def build_new(cls,
                  character_id: EntityId,
                  name: Name,
                  species: Species,
                  gender: Gender,
                  origin_location: Optional[ShortLocation],
                  current_location: ShortLocation,
                  type: CharacterType,
                  image_url: ImageUrl,
                  status: Status = Status.alive):
        return Character(id=character_id,
                         name=name,
                         species=species,
                         gender=gender,
                         status=status,
                         origin_location=origin_location,
                         current_location=current_location,
                         type=type,
                         image_url=image_url,
                         created_at=datetime.now())

    def _check_action_valid_statuses(self, valid_statuses: Set[Status]):
        if self.status not in valid_statuses:
            raise InvalidStatusError()

    def prepare_to_take_place(self):
        self._check_action_valid_statuses({Status.alive, Status.unknown})
        self.status = Status.dead

    def resurrect(self):
        self._check_action_valid_statuses({Status.dead, })
        self.status = Status.alive

    def move_to(self, target_location: ShortLocation):
        if self.current_location.id == target_location.id:
            raise AlreadyHereError()
        self.current_location = target_location


