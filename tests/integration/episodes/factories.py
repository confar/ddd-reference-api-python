from datetime import datetime

import factory

from app.core.episodes.orm import EpisodeORM, EpisodeCharacterORM
from tests.base_factories import DBBaseModelFactory


class EpisodeORMFactory(DBBaseModelFactory):
    id = factory.Sequence(lambda n: n + 1)
    name = factory.Faker("word")
    season = 1
    episode_number = 1
    air_date = factory.LazyFunction(datetime.now().date)

    class Meta:
        model = EpisodeORM


class EpisodeCharacterORMFactory(DBBaseModelFactory):
    id = factory.Sequence(lambda n: n + 1)
    episode_id = factory.Faker("random_int")
    character_id = factory.Faker("random_int")

    class Meta:
        model = EpisodeCharacterORM
