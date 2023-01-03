from typing import Generator, AsyncGenerator

from fastapi import Query, HTTPException, Request
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session

from app.core.shared.domain import EntityId
from app.core.shared.exceptions import InvalidIdError
from app.core.shared.pagination import LimitOffsetPagination


async def get_db_session(request: Request) -> AsyncGenerator[AsyncSession, None]:
    async with request.app.state.database._async_session_factory() as session:
        try:
            yield session
        except Exception as error:
            await session.rollback()
            raise error
        finally:
            await session.commit()
            await session.close()


def get_entity_id_from_path(
    id: int = Query(),
) -> EntityId:
    return construct_entity_id_from_id(id)


def construct_entity_id_from_id(
    id: int,
) -> EntityId:
    try:
        entity_id = EntityId(id)
    except InvalidIdError:
        raise HTTPException(status_code=400, detail="Id should be positive")
    return entity_id


def construct_entity_ids_from_ids(
    ids: list[int],
) -> list[EntityId]:
    entity_ids = []
    for id in ids:
        entity_id = construct_entity_id_from_id(id)
        entity_ids.append(entity_id)
    return entity_ids


def get_limit_offset_pagination_params(
    request: Request,
    offset: int = Query(default=0, ge=0, description="Пропустить первые в выдаче N объектов до этого значения"),
    limit: int = Query(
        default=10,
        ge=1,
        le=500,
        description="Верхний лимит объектов в выдаче",
    ),
) -> LimitOffsetPagination:
    return LimitOffsetPagination(limit=limit, offset=offset, request_url=request.url)

