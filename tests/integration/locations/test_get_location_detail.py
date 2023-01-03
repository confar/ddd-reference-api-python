import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.characters.factories import CharacterORMFactory
from tests.integration.locations.factories import LocationORMFactory


pytestmark = [
    pytest.mark.anyio,
]

async def test_get_location_by_id(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    location = LocationORMFactory()

    response = await rest_client.get(
        f"api/locations/{location.id}",
    )
    assert response.status_code == 200

    data = response.json()
    assert data == {
        'created_at': location.created_at.isoformat(),
        'dimension': location.dimension,
        'id': location.id,
        'name': location.name,
        'residents': []
    }


async def test_get_location_with_residents(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    location = LocationORMFactory()
    character_one = CharacterORMFactory(current_location=location)
    character_two = CharacterORMFactory(current_location=location)

    response = await rest_client.get(
        f"api/locations/{location.id}",
    )
    assert response.status_code == 200

    data = response.json()
    assert data['residents'] == [
        {'id': character_one.id,
         'name': character_one.name,
         'species': character_one.species,
         'status': character_one.status},
        {'id': character_two.id,
         'name': character_two.name,
         'species': character_two.species,
         'status': character_two.status}
    ]