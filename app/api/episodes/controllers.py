from fastapi import APIRouter, Depends, Query

from app.api.base_deps import get_limit_offset_pagination_params, get_entity_id_from_path, construct_entity_id_from_id
from app.api.episodes.deps import get_episode_service
from app.api.responses import build_responses
from app.core.shared.domain import EntityId
from app.core.episodes.dto import EpisodeDTO
from app.core.episodes.services import EpisodeService
from app.core.shared.pagination import LimitOffsetPagination

router = APIRouter()


@router.get(
    "/episodes",
    name="episodes:get_all",
    description='Получить список всех эпизодов сериала',
    responses=build_responses(status_code=200, response_model=list[EpisodeDTO])
)
async def get_episodes(
    pagination: LimitOffsetPagination = Depends(get_limit_offset_pagination_params),
    episode_service: EpisodeService = Depends(get_episode_service),
) -> list[EpisodeDTO]:
    episodes = await episode_service.get_episodes_page(pagination)
    return [EpisodeDTO.from_domain(episode) for episode in episodes]


@router.get(
    "/episodes/{id}",
    name="episodes:get_all",
    description='Получить детальную информацию об эпизоде',
    responses=build_responses(status_code=200, response_model=EpisodeDTO)
)
async def get_episode_detail(
    episode_id: EntityId = Depends(get_entity_id_from_path),
    episode_service: EpisodeService = Depends(get_episode_service),
) -> EpisodeDTO:
    episode = await episode_service.get_episode_by(episode_id)
    return EpisodeDTO.from_domain(episode)

