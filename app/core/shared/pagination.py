from dataclasses import dataclass
from typing import Tuple

from starlette.datastructures import URL


@dataclass
class LimitOffsetPagination:
    limit: int
    offset: int
    request_url: URL

    def _get_page_uri(self, offset: int | None) -> str | None:
        if offset is None or offset < 0:
            return None
        url = self.request_url.remove_query_params("offset")
        url = url.include_query_params(**{"offset": offset})
        page_uri = url.path + "?" + url.query
        return page_uri

    def build_pages(self, next_offset: int | None) -> Tuple[str | None, str | None]:
        next_page = self._get_page_uri(next_offset)
        previous_offset = self.offset - self.limit
        previous_page = self._get_page_uri(previous_offset)
        return previous_page, next_page