## first start

### ставим зависимости
poetry install

### запускаем postgresql локально
docker compose up

### мигрируем данные (на выбор через csv или через дамп базы данных)
python app/cli/main.py

### запускаем приложение
python app/main.py

## Запуск тестов

docker compose -f tests/docker-compose.yml up

LOCALTEST=1 pytest tests -n auto
