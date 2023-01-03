from sqladmin import ModelView

from app.core.locations.orm import LocationORM


class LocationAdmin(ModelView, model=LocationORM):
    column_list = [LocationORM.id, LocationORM.name,
                   LocationORM.dimension, LocationORM.type]