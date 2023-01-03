import re
from datetime import date

from app.core.characters.shared.domain import ShortCharacter
from app.core.shared.domain import Name, EntityId
from app.core.episodes.exceptions import InvalidSequenceError


class EpisodeSequence:
    """Examples:
    S01E01
    S01E02
    S04E03
    S10E6
    """
    def __init__(self, episode_sequence: str):
        try:
            _, season_id, episode_number = re.split('S|E', episode_sequence)
        except Exception:
            raise InvalidSequenceError()
        self.season_id = int(season_id)
        self.episode_number = int(episode_number)


class Episode:
    def __init__(self,
                 id: EntityId,
                 name: Name,
                 air_date: date,
                 episode_sequence: EpisodeSequence,
                 characters: list[ShortCharacter]):
        self.id = id
        self.characters = characters
        self.episode_sequence = episode_sequence
        self.name = name
        self.air_date = air_date
