from app.core.shared.exceptions import InvalidIdError, InvalidNameError
from dataclasses import dataclass


class Name:
    def __init__(self, name: str):
        if not name or len(name) > 255:
            raise InvalidNameError()
        self.value = name


@dataclass(frozen=True)
class EntityId:
  value: int
    
  def __post_init__(self):
    if self.value < 1:
      raise InvalidIdError

