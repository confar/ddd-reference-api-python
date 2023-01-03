import datetime

import pytest
from pydantic import ValidationError

from app.core.characters.domain import Status, ImageUrl
from app.core.characters.exceptions import InvalidStatusError, CharacterTypeError, InvalidImageFormatError
from tests.unit.characters.factories import CharacterFactory


def test_empty_character_type_results_in_empty_string():
    character = CharacterFactory(type__name=None)
    assert character.type.name == ''


def test_character_type_too_long_error():
    with pytest.raises(CharacterTypeError):
        CharacterFactory(type__name='f' * 101)


def test_image_url_doesnt_end_on_right_formar_error():
    with pytest.raises(InvalidImageFormatError):
        ImageUrl(url='http://google.com/')


@pytest.mark.parametrize('kwargs', [
    {'character_id': None},
    {'status': None},
    {'gender': None},
    {'species': None},
    {'name': None},
    {'type': None},
    {'current_location': None},
])
def test_empty_values_in_constructor_results_in_error(kwargs):
    with pytest.raises(ValidationError):
        CharacterFactory(**kwargs)


def test_resurrect_while_alive_should_return_error():
    character = CharacterFactory(status=Status.alive)
    with pytest.raises(InvalidStatusError):
        character.resurrect()


def test_report_dead_while_dead_should_return_error():
    character = CharacterFactory(status=Status.dead)
    with pytest.raises(InvalidStatusError):
        character.prepare_to_take_place()


def test_prepare_to_take_place_success():
    character = CharacterFactory(status=Status.alive)
    character.prepare_to_take_place()
    assert character.status == Status.dead


def test_resurrect_success():
    character = CharacterFactory(status=Status.dead)
    character.resurrect()
    assert character.status == Status.alive


@pytest.mark.freeze_time("2022-02-22")
def test_newly_added_character_created_at_is_now():
    character = CharacterFactory()
    assert (character.created_at.replace(microsecond=0).isoformat() ==
            datetime.datetime.now().replace(microsecond=0).isoformat())


def test_newly_added_character_is_alive_by_default():
    character = CharacterFactory()
    assert character.status == Status.alive
