import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.characters.factories import CharacterORMFactory
from tests.integration.locations.factories import LocationORMFactory


pytestmark = [
    pytest.mark.anyio,
]


async def test_character_move(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    origin_location = LocationORMFactory()
    character = CharacterORMFactory(origin_location=origin_location,
                                    current_location=origin_location)
    new_location = LocationORMFactory()
    response = await rest_client.put(f"api/characters/{character.id}/move",
                                     json={'location_id': new_location.id})
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
            {'dimension': new_location.dimension,
             'id': new_location.id,
             'name': new_location.name},
        'origin_location': {'dimension': origin_location.dimension,
             'id': origin_location.id,
             'name': origin_location.name},
    }