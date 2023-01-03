from fastapi import APIRouter, Depends
from fastapi.openapi.docs import get_swagger_ui_html

from app.api.characters.deps import get_character_service
from app.api.episodes.deps import get_episode_service
from app.api.locations.deps import get_location_service
from app.core.characters.dto import CharacterDTO
from app.core.characters.services import CharacterService
from app.core.episodes.services import EpisodeService
from app.core.locations.services import LocationService

router = APIRouter()


@router.get(
    "/docs",
    name="docs:get_open_api",
    include_in_schema=False,
)
def read_docs():
    return get_swagger_ui_html(openapi_url="/openapi.json", title='Hack Api')
