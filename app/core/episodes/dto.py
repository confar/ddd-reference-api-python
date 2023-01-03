from datetime import datetime, date

from pydantic import BaseModel

from app.core.characters.shared.dto import ShortCharacterDTO
from app.core.episodes.domain import Episode


class EpisodeDTO(BaseModel):
    id: int
    name: str
    season_id: int
    episode_number: int
    air_date: date
    characters: list[ShortCharacterDTO]

    @classmethod
    def from_domain(cls, episode: Episode) -> "EpisodeDTO":
        return cls(id=episode.id.value,
                   name=episode.name.value,
                   season_id=episode.episode_sequence.season_id,
                   episode_number=episode.episode_sequence.episode_number,
                   air_date=episode.air_date,
                   characters=[ShortCharacterDTO.from_domain(character) for character in episode.characters])
