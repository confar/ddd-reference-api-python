import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.adventures.factories import AdventureORMFactory
from tests.integration.locations.factories import LocationORMFactory

pytestmark = [
    pytest.mark.anyio,
]


async def test_get_adventure_by_id(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    location = LocationORMFactory()
    adventure = AdventureORMFactory(location=location)

    response = await rest_client.get(
        f"api/adventures/{adventure.id}",
    )
    assert response.status_code == 200

    data = response.json()
    assert data == {
        'started_at': adventure.started_at.isoformat(),
        'active_till': adventure.active_till.isoformat(),
        'location': {'dimension': location.dimension,
             'id': location.id,
             'name': location.name},
        'id': adventure.id,
        'name': adventure.name,
        'participants': [],
    }