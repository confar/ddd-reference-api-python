from datetime import datetime

import factory

from app.core.locations.domain import LocationType
from app.core.locations.orm import LocationORM
from app.core.locations.shared.domain import Dimension
from tests.base_factories import DBBaseModelFactory


class LocationORMFactory(DBBaseModelFactory):
    id = factory.Sequence(lambda n: n + 1)
    name = factory.Faker("word")
    dimension = factory.Faker("enum", enum_cls=Dimension)
    type = factory.Faker("enum", enum_cls=LocationType)

    created_at = factory.LazyFunction(datetime.now)

    class Meta:
        model = LocationORM
