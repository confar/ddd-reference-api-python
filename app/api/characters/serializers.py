from pydantic import BaseModel

class MoveToLocationRequest(BaseModel):
    location_id: int