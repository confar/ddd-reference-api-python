from datetime import datetime

import factory

from app.core.characters.domain import Character, CharacterType, Gender, Species, ImageUrl
from app.core.locations.domain import Location, LocationType
from app.core.locations.shared.domain import Dimension, ShortLocation
from app.core.shared.domain import Name, EntityId
from tests.base_factories import DBBaseModelFactory
from tests.unit.base_factories import EntityIdFactory, NameFactory


class LocationFactory(factory.Factory):
    class Meta:
        model = Location

    id = factory.SubFactory(EntityIdFactory)
    name = factory.SubFactory(NameFactory)
    dimension = factory.Faker("random_element", elements=Dimension.display_values())
    type = factory.Faker("random_element", elements=LocationType.display_values())
    created_at = factory.LazyFunction(datetime.now)
    residents = []


class ShortLocationFactory(factory.Factory):
    class Meta:
        model = ShortLocation

    id = factory.SubFactory(EntityIdFactory)
    name = factory.SubFactory(NameFactory)
    dimension = factory.Faker("random_element", elements=Dimension.display_values())
