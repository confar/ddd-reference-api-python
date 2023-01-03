from sqladmin import ModelView

from app.core.episodes.orm import EpisodeORM


class EpisodeAdmin(ModelView, model=EpisodeORM):
    column_list = [EpisodeORM.id, EpisodeORM.name,
                   EpisodeORM.air_date,
                   EpisodeORM.season,
                   EpisodeORM.episode_number]
