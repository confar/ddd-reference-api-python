from fastapi import APIRouter, Depends

from app.api.base_deps import get_limit_offset_pagination_params, get_entity_id_from_path
from app.api.locations.deps import get_location_service
from app.api.locations.serializers import MoveToDimensionRequest
from app.core.shared.domain import EntityId
from app.core.locations.dto import LocationDTO
from app.core.locations.services import LocationService
from app.core.shared.pagination import LimitOffsetPagination

router = APIRouter()


@router.get(
    "/locations",
    name="locations:get_all",
    description='Получить список всех локаций'
)
async def get_locations(
    pagination: LimitOffsetPagination = Depends(get_limit_offset_pagination_params),
    location_service: LocationService = Depends(get_location_service),
) -> list[LocationDTO]:
    locations = await location_service.get_locations_page(pagination)
    return [LocationDTO.from_domain(location) for location in locations]


@router.get(
    "/locations/{id}",
    name="locations:get_all",
    description='Получить детальную инфу по локации'
)
async def get_location_detail(
    location_id: EntityId = Depends(get_entity_id_from_path),
    location_service: LocationService = Depends(get_location_service),
) -> LocationDTO:
    location = await location_service.get_location_by(location_id)
    return LocationDTO.from_domain(location)


@router.put(
    "/locations/{id}/move",
    name="locations:get_all",
    description='Переместить локацию в другое измерение'
)
async def move_location_to_other_location(
    payload: MoveToDimensionRequest,
    location_id: EntityId = Depends(get_entity_id_from_path),
    location_service: LocationService = Depends(get_location_service),
) -> LocationDTO:
    location = await location_service.move_location_to_another_dimension(location_id,
                                                                         target_dimension=payload.dimension)
    return LocationDTO.from_domain(location)
