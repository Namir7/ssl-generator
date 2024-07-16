1. Устанавливаем переменную окружения домена в .env `DOMAIN_URL`
2. Запускаем nginx `docker-compose up -d nginx`
3. Запускаем демон обновление сертификата `bash scripts/infinity-loop.sh &`

Если понадобится убить процесс, то находим по имени скрипта 
`ps aux | grep infinity-loop` и удалеям процесс `kill -9 <pid>`