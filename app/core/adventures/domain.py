import re
from datetime import datetime

from dateutil.relativedelta import relativedelta
from pydantic.dataclasses import dataclass

from app.core.characters.shared.domain import ShortCharacter
from app.core.locations.shared.domain import ShortLocation
from app.core.shared.domain import Name, EntityId


@dataclass(config=dict(arbitrary_types_allowed=True))
class Adventure:
    id: EntityId
    name: Name
    location: ShortLocation
    started_at: datetime
    active_till: datetime
    participants: list[ShortCharacter]

    @classmethod
    def build_new(cls,
                  id: EntityId,
                  name: Name,
                  location: ShortLocation,
                  duration_minutes: int,
                  participants: list[ShortCharacter]):
        started_at = datetime.now()
        return Adventure(id=id,
                         name=name,
                         started_at=datetime.now(),
                         active_till=started_at + relativedelta(minutes=duration_minutes),
                         location=location,
                         participants=participants)