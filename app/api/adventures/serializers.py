from pydantic import BaseModel


class GoOnAdventureRequest(BaseModel):
    name: str
    participant_ids: list[int]
    duration_minutes: int
    location_id: int
