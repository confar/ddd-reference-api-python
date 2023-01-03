import csv
from datetime import datetime

from sqlalchemy import select, update, insert, bindparam, null
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session, joinedload

from app.core.characters.domain import Character
from app.core.characters.orm import CharacterORM
from app.core.characters.shared.domain import ShortCharacter
from app.core.shared.domain import EntityId
from app.core.shared.pagination import LimitOffsetPagination


class NotAllCharactersFound(Exception):
    pass


class CharacterCSVRepository:
    CHARACTER_CSV_PATH = './app/core/characters/data/characters.csv'

    def get_characters(self) -> list[CharacterORM]:
        characters = []
        with open(self.CHARACTER_CSV_PATH) as file:
            character_rows = csv.DictReader(file, delimiter=',')
            for row in character_rows:
                character = CharacterORM(id=int(row['id']),
                                         name=row['name'],
                                         status=row['status'],
                                         gender=row['gender'],
                                         species=row['species'],
                                         type=row['type'],
                                         image_url=row['image_url'] if row['image_url'] else None,
                                         origin_location_id=int(
                                             row['origin_location_id']) if row['origin_location_id'] else None,
                                         current_location_id=int(row['current_location_id']),
                                         created_at=datetime.strptime(row['created_at'],
                                                                      '%Y-%m-%d %H:%M:%S.%f'))
                characters.append(character)
        return characters


class CharacterRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_characters_page(self, pagination: LimitOffsetPagination) -> list[Character]:
        query = (select(CharacterORM)
                 .options(joinedload(CharacterORM.current_location, innerjoin=False),
                          joinedload(CharacterORM.origin_location, innerjoin=False))
                 .limit(pagination.limit).offset(pagination.offset))
        result = await self.session.execute(query)
        characters_orm = result.scalars().all()
        characters = []
        for character_orm in characters_orm:
            characters.append(character_orm.to_domain())
        return characters

    async def get_character_by(self, id: EntityId) -> Character:
        query = select(CharacterORM).options(
            joinedload(CharacterORM.current_location, innerjoin=False),
            joinedload(CharacterORM.origin_location, innerjoin=False)
        ).where(CharacterORM.id == id.value)
        result = await self.session.execute(query)
        return result.scalar_one().to_domain()

    async def get_all_characters_by(self, ids: list[EntityId]) -> list[ShortCharacter]:
        query = select(CharacterORM).options(
            joinedload(CharacterORM.current_location, innerjoin=False),
            joinedload(CharacterORM.origin_location, innerjoin=False)
        ).where(CharacterORM.id.in_([character_id.value for character_id in ids]))
        result = await self.session.execute(query)
        characters_orm = result.scalars().all()
        characters = [character.to_domain_short_character() for character in characters_orm]
        if len(characters) != len(ids):
            raise NotAllCharactersFound()
        return characters

    async def get_all_characters(self) -> list[ShortCharacter]:
        query = select(CharacterORM).where(CharacterORM.image_url == null()).limit(300)
        result = await self.session.execute(query)
        characters = result.scalars()
        return characters

    async def update_character_status(self, character: Character) -> None:
        query = update(CharacterORM).values(status=character.status).where(CharacterORM.id == character.id.value)
        await self.session.execute(query)

    async def update_character_location(self, character: Character) -> None:
        query = (update(CharacterORM).values(
            current_location_id=character.current_location.id.value).where(
            CharacterORM.id == character.id.value))
        await self.session.execute(query)

    async def populate_data_from_csv(self, characters: list[CharacterORM]):
        self.session.add_all(characters)
        await self.session.flush()
        await self.session.commit()

