from fastapi import Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session

from app.api.base_deps import get_db_session
from app.core.episodes.repositories import EpisodeRepository, EpisodeCSVRepository
from app.core.episodes.services import EpisodeService


def get_episode_repository(
    session: AsyncSession = Depends(get_db_session),
) -> EpisodeRepository:
    return EpisodeRepository(session=session)


def get_episode_csv_repository(
) -> EpisodeCSVRepository:
    return EpisodeCSVRepository()


def get_episode_service(
    repository: EpisodeRepository = Depends(get_episode_repository),
    csv_repository: EpisodeCSVRepository = Depends(get_episode_csv_repository),

) -> EpisodeService:
    return EpisodeService(repository=repository, csv_repository=csv_repository)
