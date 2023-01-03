from datetime import datetime, timedelta

import factory

from app.core.adventures.orm import AdventureORM
from tests.base_factories import DBBaseModelFactory
from tests.integration.locations.factories import LocationORMFactory


class AdventureORMFactory(DBBaseModelFactory):
    id = factory.Sequence(lambda n: n + 1)
    name = factory.Faker("word")
    started_at = factory.LazyFunction(datetime.now)
    active_till = factory.Faker(
        "date_time_between_dates",
        datetime_start=datetime.now(),
        datetime_end=datetime.now() + timedelta(days=15)
    )
    location = factory.SubFactory(LocationORMFactory)
    location_id = factory.LazyAttribute(lambda obj: obj.location.id)

    class Meta:
        model = AdventureORM
