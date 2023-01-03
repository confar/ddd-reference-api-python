import csv
from datetime import datetime

from sqlalchemy import select, update, insert
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session, joinedload

from app.core.locations.dto import LocationCsvDTO
from app.core.locations.shared.domain import ShortLocation
from app.core.shared.domain import EntityId
from app.core.locations.domain import Location
from app.core.locations.orm import LocationORM
from app.core.shared.pagination import LimitOffsetPagination


class LocationCSVRepository:
    LOCATION_CSV_PATH = './app/core/locations/data/locations.csv'

    def get_locations(self) -> list[LocationORM]:
        locations = []
        with open(self.LOCATION_CSV_PATH) as file:
            location_rows = csv.DictReader(file, delimiter=',')
            for row in location_rows:
                location = LocationORM(id=int(row['id']),
                                       name=row['name'],
                                       type=row['type'],
                                       dimension=row['dimension'],
                                       created_at=datetime.strptime(row['created_at'],
                                                                        '%Y-%m-%d %H:%M:%S.%f'))
                locations.append(location)
        return locations


class LocationRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_locations_page(self, pagination: LimitOffsetPagination) -> list[Location]:
        query = (select(LocationORM)
                 .options(joinedload(LocationORM.residents, innerjoin=False))
                 .limit(pagination.limit).offset(pagination.offset))
        result = await self.session.execute(query)
        locations_orm = result.unique().scalars().all()
        locations = []
        for location_orm in locations_orm:
            locations.append(location_orm.to_location())
        return locations

    async def get_location_by(self, id: EntityId) -> Location:
        query = (select(LocationORM)
            .options(joinedload(LocationORM.residents, innerjoin=False)
        ).where(LocationORM.id == id.value))
        result = await self.session.execute(query)
        return result.unique().scalar_one().to_location()

    async def get_short_location_by(self, id: EntityId) -> ShortLocation:
        query = (select(LocationORM)
        ).where(LocationORM.id == id.value)
        result = await self.session.execute(query)
        return result.unique().scalar_one().to_short_location()

    async def save_new_dimension(self, location: Location) -> None:
        query = update(LocationORM).values(dimension=location.dimension).where(LocationORM.id ==
                                                                               location.id.value)
        await self.session.execute(query)

    async def populate_data_from_csv(self, locations: list[LocationORM]) -> None:
        self.session.add_all(locations)
        await self.session.flush()
        await self.session.commit()
