import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.characters.factories import CharacterORMFactory
from tests.integration.locations.factories import LocationORMFactory

pytestmark = [
    pytest.mark.anyio,
]


async def test_get_characters(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    location_one = LocationORMFactory()
    character_one = CharacterORMFactory(origin_location=location_one, current_location=location_one)
    location_two = LocationORMFactory()
    character_two = CharacterORMFactory(origin_location=location_two, current_location=location_two)

    response = await rest_client.get(f"api/characters")
    assert response.status_code == 200
    data = response.json()
    assert data == [
        {
            'gender': character_one.gender,
            'id': character_one.id,
            'image_url': character_one.image_url,
            'name': character_one.name,
            'species': character_one.species,
            'status': character_one.status,
            'type': character_one.type,
            'current_location':
                {'dimension': location_one.dimension,
                 'id': location_one.id,
                 'name': location_one.name},
            'origin_location': {'dimension': location_one.dimension,
                                'id': location_one.id,
                                'name': location_one.name},
        },
        {
            'gender': character_two.gender,
            'id': character_two.id,
            'image_url': character_two.image_url,
            'name': character_two.name,
            'species': character_two.species,
            'status': character_two.status,
            'type': character_two.type,
            'current_location':
                {'dimension': location_two.dimension,
                 'id': location_two.id,
                 'name': location_two.name},
            'origin_location': {'dimension': location_two.dimension,
                                'id': location_two.id,
                                'name': location_two.name},
        }
    ]


