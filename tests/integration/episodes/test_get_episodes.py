import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.characters.factories import CharacterORMFactory
from tests.integration.episodes.factories import EpisodeORMFactory, EpisodeCharacterORMFactory

pytestmark = [
    pytest.mark.anyio,
]


async def test_get_episodes(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    rick = CharacterORMFactory(name='Rick Sanchez')
    morty = CharacterORMFactory(name='Morty Smith')

    episode1 = EpisodeORMFactory()
    EpisodeCharacterORMFactory(episode_id=episode1.id, character_id=rick.id)
    EpisodeCharacterORMFactory(episode_id=episode1.id, character_id=morty.id)

    episode2 = EpisodeORMFactory(episode_number=2)
    EpisodeCharacterORMFactory(episode_id=episode2.id, character_id=rick.id)

    response = await rest_client.get(
        "api/episodes",
    )
    assert response.status_code == 200

    data = response.json()
    assert len(data) == 2
    assert data == [{
        'air_date': episode1.air_date.isoformat(),
        'season_id': 1,
        'episode_number': 1,
        'id': episode1.id,
        'name': episode1.name,
        'characters': [
            {'id': rick.id,
             'name': 'Rick Sanchez',
             'species': rick.species,
             'status': rick.status},
            {'id': morty.id,
             'name': 'Morty Smith',
             'species': morty.species,
             'status': morty.status}
        ],
    },
        {'air_date': episode2.air_date.isoformat(),
        'season_id': 1,
        'episode_number': 2,
        'id': episode2.id,
        'name': episode2.name,
        'characters': [
            {'id': rick.id,
             'name': 'Rick Sanchez',
             'species': rick.species,
             'status': rick.status},
         ]
         }
    ]