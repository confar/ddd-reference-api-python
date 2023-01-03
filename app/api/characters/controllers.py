from fastapi import APIRouter, Depends

from app.api.base_deps import get_limit_offset_pagination_params, get_entity_id_from_path, construct_entity_id_from_id
from app.api.characters.deps import get_character_service
from app.api.characters.serializers import MoveToLocationRequest
from app.api.episodes.deps import get_episode_service
from app.api.locations.deps import get_location_service
from app.api.responses import build_responses
from app.core.characters.dto import CharacterDTO
from app.core.characters.services import CharacterService
from app.core.shared.domain import EntityId
from app.core.episodes.services import EpisodeService
from app.core.locations.services import LocationService
from app.core.shared.pagination import LimitOffsetPagination

router = APIRouter()


@router.get(
    "/characters",
    name="characters:get_all",
    description='Получить список всех персонажей',
    responses=build_responses(status_code=200, response_model=list[CharacterDTO])
)
async def get_characters(
    pagination: LimitOffsetPagination = Depends(get_limit_offset_pagination_params),
    character_service: CharacterService = Depends(get_character_service),
) -> list[CharacterDTO]:
    characters = await character_service.get_characters_page(pagination)
    return [CharacterDTO.from_domain(character) for character in characters]


@router.get(
    "/characters/{id}",
    name="characters:get_all",
    description='Получить детальную инфу о конкретном персонаже',
    responses=build_responses(status_code=200, response_model=CharacterDTO)
)
async def get_character_detail(
    character_id: EntityId = Depends(get_entity_id_from_path),
    character_service: CharacterService = Depends(get_character_service),
) -> CharacterDTO:
    character = await character_service.get_character_by(character_id)
    return CharacterDTO.from_domain(character)


@router.put(
    "/characters/{id}/prepare-to-take-place",
    name="characters:get_all",
    description='Приготовиться занять место персонажа. '
                'В сериале это приводило к побочному эффекту, '
                'что выбранный персонаж умирает',
    responses=build_responses(status_code=200, response_model=CharacterDTO)
)
async def prepare_to_take_characters_place(
    character_id: EntityId = Depends(get_entity_id_from_path),
    character_service: CharacterService = Depends(get_character_service),
) -> CharacterDTO:
    character = await character_service.prepare_to_take_place(character_id)
    return CharacterDTO.from_domain(character)


@router.put(
    "/characters/{id}/resurrect",
    name="characters:resurrect",
    description='Возродить персонажа',
    responses=build_responses(status_code=200, response_model=CharacterDTO)
)
async def resurrect_character(
    character_id: EntityId = Depends(get_entity_id_from_path),
    character_service: CharacterService = Depends(get_character_service),
) -> CharacterDTO:
    character = await character_service.resurrect(character_id)
    return CharacterDTO.from_domain(character)


@router.put(
    "/characters/{id}/move",
    name="characters:get_all",
    description='Переместить персонажа в выбранную локацию',
    responses=build_responses(status_code=200, response_model=CharacterDTO)
)
async def move_character_to_other_location(
    payload: MoveToLocationRequest,
    character_id: EntityId = Depends(get_entity_id_from_path),
    character_service: CharacterService = Depends(get_character_service),
) -> CharacterDTO:
    target_location_id = construct_entity_id_from_id(payload.location_id)
    character = await character_service.move_character_to(character_id,
                                                          target_location_id=target_location_id)
    return CharacterDTO.from_domain(character)

