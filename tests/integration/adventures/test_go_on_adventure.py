import pytest
from httpx import AsyncClient
from sqlalchemy.orm import Session

from tests.integration.characters.factories import CharacterORMFactory
from tests.integration.locations.factories import LocationORMFactory

pytestmark = [
    pytest.mark.anyio,
]


@pytest.mark.freeze_time("2022-02-22")
async def test_go_on_adventure(
    rest_client: AsyncClient,
    sync_db: Session
) -> None:
    location = LocationORMFactory()
    character_one = CharacterORMFactory()
    character_two = CharacterORMFactory()

    response = await rest_client.post(
        f"api/adventures",
        json={
            'name': 'Лучшее приключение',
            'location_id': location.id,
            'duration_minutes': 15,
            'participant_ids': [character_one.id,
                                character_two.id],
        }
    )
    print(response.json())
    assert response.status_code == 201

    data = response.json()
    assert data == {
        'started_at': '2022-02-22T00:00:00',
        'active_till': '2022-02-22T00:15:00',
        'location': {'dimension': location.dimension,
                     'id': location.id,
                     'name': location.name},
        'id': 1,
        'name': 'Лучшее приключение',
        'participants': [{'id': character_one.id,
                          'name': character_one.name,
                          'species': character_one.species,
                          'status': character_one.status},
                         {'id': character_two.id,
                          'name': character_two.name,
                          'species': character_two.species,
                          'status': character_two.status}],
    }
