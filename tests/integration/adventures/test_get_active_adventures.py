import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.adventures.factories import AdventureORMFactory
from tests.integration.locations.factories import LocationORMFactory

pytestmark = [
    pytest.mark.anyio,
]


async def test_get_adventures(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    location = LocationORMFactory()
    adventure1 = AdventureORMFactory(location=location)
    adventure2 = AdventureORMFactory(location=location)

    response = await rest_client.get(
        "api/adventures",
    )
    assert response.status_code == 200

    data = response.json()
    assert len(data) == 2
    data == [{
        'started_at': adventure1.started_at.isoformat(),
        'active_till': adventure1.active_till.isoformat(),
        'location': {'dimension': location.dimension,
             'id': location.id,
             'name': location.name},
        'id': adventure1.id,
        'name': adventure1.name,
        'participants': [],
    },
        {
            'started_at': adventure1.started_at.isoformat(),
            'active_till': adventure1.active_till.isoformat(),
            'location': {'dimension': location.dimension,
             'id': location.id,
             'name': location.name},
            'id': adventure2.id,
            'name': adventure2.name,
            'participants': [],
        }
    ]


