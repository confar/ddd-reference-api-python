from datetime import datetime

from pydantic.dataclasses import dataclass

from app.core.locations.shared.domain import ShortLocation
from app.core.shared.domain import EntityId, Name


@dataclass(config=dict(arbitrary_types_allowed=True))
class ShortAdventure:
    id: EntityId
    name: Name
    location: ShortLocation
    started_at: datetime
    active_till: datetime
