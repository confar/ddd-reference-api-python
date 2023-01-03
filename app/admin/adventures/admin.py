from typing import Any

from pydantic import ValidationError
from sqladmin import ModelView

from app.core.adventures.domain import Adventure
from app.core.adventures.orm import AdventureORM


class AdventureAdmin(ModelView, model=AdventureORM):
    column_list = [AdventureORM.id, AdventureORM.name,
                   AdventureORM.air_date,
                   AdventureORM.season,
                   AdventureORM.episode_number]

    async def on_model_change(self, data: dict, model: Any, is_created: bool) -> None:
        """Perform some actions before a model is created or updated.
        By default does nothing.
        """
        try:
            Adventure(id=data['id'],
                      name=data['name'],
                      location=data['location'],
                      started_at=data['started_at'],
                      active_till=data['active_till'],
                      participants=data['participants'])
        except ValidationError:
            raise
