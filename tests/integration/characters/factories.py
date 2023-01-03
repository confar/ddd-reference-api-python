from datetime import datetime

import factory
from factory import fuzzy

from app.core.characters.domain import Gender
from app.core.characters.orm import CharacterORM
from app.core.characters.shared.domain import Status, Species
from tests.base_factories import DBBaseModelFactory
from tests.integration.locations.factories import LocationORMFactory


class CharacterORMFactory(DBBaseModelFactory):
    id = factory.Sequence(lambda n: n + 1)
    name = factory.Faker("word")
    status = factory.Faker("enum", enum_cls=Status)
    type = fuzzy.FuzzyText(length=50)
    species = factory.Faker("enum", enum_cls=Species)
    gender = factory.Faker("enum", enum_cls=Gender)
    created_at = factory.LazyFunction(datetime.now)

    current_location = factory.SubFactory(LocationORMFactory)
    current_location_id = factory.LazyAttribute(lambda obj: obj.current_location.id)

    origin_location = factory.SubFactory(LocationORMFactory)
    origin_location_id = factory.LazyAttribute(lambda obj: obj.origin_location.id if obj.origin_location else None)

    class Meta:
        model = CharacterORM
