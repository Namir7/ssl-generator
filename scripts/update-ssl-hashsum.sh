#!/bin/bash

CERT_FILE="/etc/nginx/cert.pem"
NGINX_CONTAINER="nginx"
CERTBOT_CONTAINER="certbot"
# 12 hours
timeout= 43200

# Функция для получения хеша файла
get_file_hash() {
   sha256sum "$1" | awk '{ print $1 }'
}

# Изначальный хеш файла
initial_hash=$(get_file_hash "$CERT_FILE")

# Бесконечный цикл для наблюдения за изменениями
while true; do
   printf "\n Start generate ssl certificates\n"
   current_datetime=$(date +"%Y-%m-%d %H:%M:%S.%3N")
   echo $current_datetime
   # Обновление сертификатов с помощью certbot
   docker-compose up "$CERTBOT_CONTAINER"

   # Хеш файла после выполнения команды certbot
   new_hash=$(get_file_hash "$CERT_FILE")

   # Проверка изменения хеша
   if [ "$initial_hash" != "$new_hash" ]; then
      echo "Certificate has been updated. Reloading NGINX..."

      # Перезагрузка NGINX в контейнере Docker
      docker exec "$NGINX_CONTAINER" nginx -s reload

      # Обновление начального хеша
      initial_hash=$new_hash
   fi

   # Ожидание перед следующей проверкой (например, 24 часа)
   sleep $timeout
done

