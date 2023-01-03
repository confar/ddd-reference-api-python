import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from app.core.locations.shared.domain import Dimension
from tests.integration.locations.factories import LocationORMFactory


pytestmark = [
    pytest.mark.anyio,
]


async def test_move_location_to_another_dimension(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    location = LocationORMFactory(dimension=Dimension.c_137)

    response = await rest_client.put(
        f"api/locations/{location.id}/move",
        json={'dimension': Dimension.chair_dimension.value}
    )
    assert response.status_code == 200

    data = response.json()
    assert data == {
        'created_at': location.created_at.isoformat(),
        'dimension': Dimension.chair_dimension.value,
        'id': location.id,
        'name': location.name,
        'residents': []
    }