from sqlalchemy import select, update, func, text
from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session, joinedload

from app.core.shared.domain import EntityId
from app.core.adventures.domain import Adventure
from app.core.adventures.orm import AdventureORM, AdventureParticipantORM


class AdventureRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_active_adventures(self) -> list[Adventure]:
        query = (select(AdventureORM)
                 .options(
            joinedload(AdventureORM.location),
            joinedload(AdventureORM.participants, innerjoin=False))
                 .where(AdventureORM.active_till >= func.now()))
        result = await self.session.execute(query)
        adventures_orm = result.unique().scalars().all()
        adventures = []
        for adventure_orm in adventures_orm:
            adventures.append(adventure_orm.to_domain_adventure())
        return adventures

    async def get_adventure_by(self, id: EntityId) -> Adventure:
        query = (select(AdventureORM)
                 .options(joinedload(AdventureORM.participants, innerjoin=False),
                          joinedload(AdventureORM.location)
        ).where(AdventureORM.id == id.value))
        result = await self.session.execute(query)
        return result.unique().scalar_one().to_domain_adventure()

    async def get_next_adventure_id(self) -> EntityId:
        query = text('select last_value from adventures_id_seq')
        result = await self.session.execute(query)
        return EntityId(result.scalar_one())

    async def arrange_aventure(self, adventure: Adventure) -> None:
        adventure_orm = AdventureORM.from_domain(adventure)
        participants_orm = AdventureParticipantORM.from_domain(adventure)
        self.session.add_all([adventure_orm, *participants_orm])
        await self.session.flush()
