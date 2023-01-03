import enum

from pydantic.dataclasses import dataclass

from app.core.shared.domain import EntityId, Name
from app.core.shared.mixins import DisplayValuesMixin

class Dimension(str, DisplayValuesMixin, enum.Enum):
    unknown = 'unknown'
    c_137 = 'c_137'
    c_500_a = 'c_500_a'
    post_apocalyptic_dimension = 'post_apocalyptic_dimension'
    replacement_dimension = 'replacement_dimension'
    fantasy_dimension = 'fantasy_dimension'
    testicle_monster_dimension = 'testicle_monster_dimension'
    giant_telepathic_spiders_dimension = 'giant_telepathic_spiders_dimension'
    pizza_dimension = 'pizza_dimension'
    chair_dimension = 'chair_dimension'
    phone_dimension = 'phone_dimension'


@dataclass(config=dict(arbitrary_types_allowed=True))
class ShortLocation:
    id: EntityId
    name: Name
    dimension: Dimension
