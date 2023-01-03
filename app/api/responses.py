from typing import Any, Type

from pydantic import BaseModel


def build_responses(
    *,
    status_code: int,
    response_model: Type[BaseModel] | Type[list[BaseModel]],
) -> dict[Any, Any]:
    responses = {status_code: {"model": response_model}}
    return responses