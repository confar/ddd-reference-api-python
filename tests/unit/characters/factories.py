import factory

from app.core.characters.domain import Character, CharacterType, Gender, Species, ImageUrl
from app.core.shared.domain import Name, EntityId
from tests.base_factories import DBBaseModelFactory
from tests.unit.base_factories import NameFactory, EntityIdFactory
from tests.unit.locations.factories import LocationFactory, ShortLocationFactory


class CharacterTypeFactory(factory.Factory):
    class Meta:
        model = CharacterType
    name = factory.Faker("name")


class ImageUrlFactory(factory.Factory):
    class Meta:
        model = ImageUrl
    url = factory.Faker("uri")

    @classmethod
    def _adjust_kwargs(cls, **kwargs):
        kwargs['url'] = f"{kwargs['url']}image.png"
        return kwargs


class CharacterFactory(factory.Factory):
    class Meta:
        model = Character

    character_id = factory.SubFactory(EntityIdFactory)
    name = factory.SubFactory(NameFactory)
    species = factory.Faker("random_element", elements=Species.display_values())
    gender = factory.Faker("random_element", elements=Gender.display_values())
    type = factory.SubFactory(CharacterTypeFactory)
    origin_location = factory.SubFactory(ShortLocationFactory)
    current_location = factory.SubFactory(ShortLocationFactory)
    image_url = factory.SubFactory(ImageUrlFactory)

    @classmethod
    def _create(cls, model_class, *args, **kwargs):
        return Character.build_new(*args, **kwargs)
