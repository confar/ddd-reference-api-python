import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.characters.factories import CharacterORMFactory
from tests.integration.episodes.factories import EpisodeORMFactory, EpisodeCharacterORMFactory

pytestmark = [
    pytest.mark.anyio,
]


async def test_get_episode_by_id(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    episode = EpisodeORMFactory()
    character = CharacterORMFactory()
    EpisodeCharacterORMFactory(episode_id=episode.id, character_id=character.id)

    response = await rest_client.get(
        f"api/episodes/{episode.id}",
    )
    assert response.status_code == 200

    data = response.json()
    assert data == {
        'air_date': episode.air_date.isoformat(),
        'season_id': 1,
        'episode_number': 1,
        'id': episode.id,
        'name': episode.name,
        'characters': [
            {'id': character.id,
             'name': character.name,
             'species': character.species,
             'status': character.status}
        ]
    }
