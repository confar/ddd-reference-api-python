from sqladmin import ModelView

from app.core.characters.orm import CharacterORM


class CharacterAdmin(ModelView, model=CharacterORM):
    column_list = [CharacterORM.id, CharacterORM.name,
                   CharacterORM.status, CharacterORM.created_at,
                   CharacterORM.species]
