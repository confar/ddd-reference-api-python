from pydantic import BaseModel

from app.core.locations.domain import Dimension


class MoveToDimensionRequest(BaseModel):
    dimension: Dimension