# Check dependencies
Проверяем, что все зависимости установлены

`docker --version`
`docker compose --version`

# Prerequsites
1. Устанавливаем переменную окружения домена в .env `DOMAIN_URL`
2. Убираем флаги для безопасного запуска `--staging` `--break-my-certs` в `scripts/run-certbot.sh`

# Run
1. Запускаем инициализации `bash scripts/init.sh`
2. Запускаем докер контейнер nginx-a `docker compose up -d nginx`
3. Запускаем скрипт повторной генерации сертификата, как демон `bash scripts/infinity-loop.sh >> .logs &`

# Stop
Если понадобится убить процесс, то находим по имени скрипта 
`ps aux | grep infinity-loop` и удалеям процесс `kill -9 <pid>`