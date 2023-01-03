import factory

from app.core.shared.domain import Name, EntityId


class NameFactory(factory.Factory):
    class Meta:
        model = Name
    name = factory.Faker("name")


class EntityIdFactory(factory.Factory):
    class Meta:
        model = EntityId
    id = factory.Sequence(lambda n: n + 1)
