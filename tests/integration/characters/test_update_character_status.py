import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from app.core.characters.shared.domain import Status
from tests.integration.characters.factories import CharacterORMFactory
from tests.integration.locations.factories import LocationORMFactory


pytestmark = [
    pytest.mark.anyio,
]


async def test_character_report_death(
        rest_client: AsyncClient,
        sync_db: Session
) -> None:
    location = LocationORMFactory()
    character = CharacterORMFactory(origin_location=None,
                                    current_location=location,
                                    status=Status.alive)

    response = await rest_client.put(f"api/characters/{character.id}/prepare-to-take-place")
    assert response.status_code == 200

    data = response.json()
    assert data['status'] == Status.dead


async def test_character_resurrect(
        rest_client: AsyncClient,
        sync_db: Session
) -> None:
    location = LocationORMFactory()
    character = CharacterORMFactory(origin_location=None,
                                    current_location=location,
                                    status=Status.dead)

    response = await rest_client.put(f"api/characters/{character.id}/resurrect")
    assert response.status_code == 200

    data = response.json()
    assert data['status'] == Status.alive
