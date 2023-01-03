from typing import Any


class DisplayValuesMixin:
    __members__: dict[Any, Any]

    @classmethod
    def display_values(cls) -> tuple[str, ...]:
        return tuple(str(item.value) for name, item in cls.__members__.items())
