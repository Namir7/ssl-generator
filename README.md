0. Устанавливаем переменную окружения домена в .env `DOMAIN_URL`

1. Запускаем nginx `docker-compose up -d nginx`

2. Генерируем сертификат `bash scripts/process-cert.sh`, перед этим установив `CERTBOT_CONTAINER=certbot-gen`

3. Меняем маршрут nginx конфиг `set $certbot "http://certbot-gen"` --> `set $certbot "http://certbot-renew";`

2. Меняем целевой образ докера в `process-cert.sh`: `CERTBOT_CONTAINER=certbot-renew`

4. Запускаем демон обновление сертификата `bash scripts/infinity-loop.sh &`

Если понадобится убить процесс, то находим по имени скрипта 
`ps aux | grep infinity-loop`
`kill -9 <pid>`