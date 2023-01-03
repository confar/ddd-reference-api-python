import asyncio
import subprocess
import questionary
import typer
from questionary.form import form

from app.cli.containers import deps_provider
from app.cli.enum import BaseEnum
from app.core.characters.services import CharacterService
from app.core.episodes.services import EpisodeService

from app.infra.database import Database
from app.core.locations.services import LocationService
from rodi import GetServiceContext
from rich.console import Console


app = typer.Typer(
    add_completion=False,
    help="Migrate data from dump or csv",
    name="Migration Tool",
)


class Migration(BaseEnum):
    from_db_dump = 'from_db_dump'
    from_csv = 'from_csv'


async def _start_csv_migration(
) -> None:
    with GetServiceContext(provider=deps_provider) as context:  # type: ignore
        database: Database = deps_provider.get(Database, context=context)
        location_service: LocationService = deps_provider.get(LocationService, context=context)
        character_service: CharacterService = deps_provider.get(CharacterService, context=context)
        episode_service: EpisodeService = deps_provider.get(EpisodeService, context=context)
        await database.create_tables()
        await location_service.populate_data_from_csv()
        await character_service.populate_data_from_csv()
        await episode_service.populate_data_from_csv()


@app.command(help="Creates a FastAPI project.")
def migrate():
    console = Console()
    result = form(
        packaging=questionary.select(f"Select the migration way: ",
                                     choices=list(Migration)),
    ).ask()
    if result == Migration.from_db_dump:
        docker_miration = 'cat dump.sql | docker exec -i hack_api-postgresql-1 psql -U hack_api_user --dbname=hack_api'
        subprocess.call(docker_miration, shell=True)
        console.print('docker database migration successfull')
    else:
        asyncio.run(_start_csv_migration())
        console.print('CSV migration successfull')


if __name__ == "__main__":
    app()
