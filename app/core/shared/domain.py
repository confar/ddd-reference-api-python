from app.core.shared.exceptions import InvalidIdError, InvalidNameError


class Name:
    def __init__(self, name: str):
        if not name or len(name) > 255:
            raise InvalidNameError()
        self.value = name


class EntityId:
    def __init__(self, id: int):
        if id < 1:
            raise InvalidIdError
        self.value = id

