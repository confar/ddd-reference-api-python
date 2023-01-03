from fastapi import APIRouter, Depends, Query

from app.api.adventures.serializers import GoOnAdventureRequest
from app.api.base_deps import get_entity_id_from_path, construct_entity_id_from_id, construct_entity_ids_from_ids
from app.api.adventures.deps import get_adventure_service
from app.core.shared.domain import EntityId
from app.core.adventures.dto import AdventureDTO
from app.core.adventures.services import AdventureService

router = APIRouter()


@router.get(
    "/adventures",
    name="adventures:get_all",
    description='Получить список всех приключений, которые продолжаются на данный момент'
)
async def get_active_adventures(
    adventure_service: AdventureService = Depends(get_adventure_service),
) -> list[AdventureDTO]:
    adventures = await adventure_service.get_active_adventures_page()
    return [AdventureDTO.from_domain(adventure) for adventure in adventures]


@router.get(
    "/adventures/{id}",
    name="adventures:get_all",
    description='Получить детальную инфу по приключению'
)
async def get_adventure_details(
    adventure_id: EntityId = Depends(get_entity_id_from_path),
    adventure_service: AdventureService = Depends(get_adventure_service),
) -> AdventureDTO:
    adventure = await adventure_service.get_adventure_by(adventure_id)
    return AdventureDTO.from_domain(adventure)


@router.post(
    "/adventures",
    name="adventures:go_on_aventure",
    status_code=201,
    description='Начать новое приключение'

)
async def go_on_aventure(
    payload: GoOnAdventureRequest,
    adventure_service: AdventureService = Depends(get_adventure_service),
) -> AdventureDTO:
    participant_ids = construct_entity_ids_from_ids(payload.participant_ids)
    location_id = construct_entity_id_from_id(payload.location_id)
    adventure = await adventure_service.go_on_adventure_with(adventure_name=payload.name,
                                                             duration_minutes=payload.duration_minutes,
                                                             location_id=location_id,
                                                             participant_ids=participant_ids)
    return AdventureDTO.from_domain(adventure)
