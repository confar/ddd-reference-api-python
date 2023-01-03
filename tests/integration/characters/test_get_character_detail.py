import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.characters.factories import CharacterORMFactory
from tests.integration.locations.factories import LocationORMFactory

pytestmark = [
    pytest.mark.anyio,
]


async def test_get_character_by_id(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    location = LocationORMFactory()
    character = CharacterORMFactory(origin_location=location, current_location=location)

    response = await rest_client.get(f"api/characters/{character.id}")
    assert response.status_code == 200

    data = response.json()
    assert data == {
                 'gender': character.gender,
                 'id': character.id,
                 'image_url': character.image_url,
                 'name': character.name,
                 'species': character.species,
                 'status': character.status,
                 'type': character.type,
        'current_location':
            {'dimension': location.dimension,
             'id': location.id,
             'name': location.name},
        'origin_location': {'dimension': location.dimension,
             'id': location.id,
             'name': location.name},
    }