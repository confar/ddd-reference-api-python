import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.locations.factories import LocationORMFactory


pytestmark = [
    pytest.mark.anyio,
]


async def test_get_locations(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    location1 = LocationORMFactory()
    location2 = LocationORMFactory()

    response = await rest_client.get(
        "api/locations",
    )
    assert response.status_code == 200

    data = response.json()
    assert len(data) == 2
    data == [{
        'created_at': location1.created_at.isoformat(),
        'dimension': location1.dimension,
        'id': location1.id,
        'name': location1.name,
        'residents': [],
    },
        {
            'created_at': location2.created_at.isoformat(),
            'dimension': location2.dimension,
            'id': location2.id,
            'name': location2.name,
            'residents': [],
        }
    ]


