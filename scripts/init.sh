NGINX_DOCKER_TAG='nginx_certbot_bootstrap'

CERT_FILE=".certbot/live/certfolder/fullchain.pem"


rollback() {
   docker stop $NGINX_DOCKER_TAG
   docker remove $NGINX_DOCKER_TAG

   docker compose down certbot

   rm -rf .certbot
   rm -rf .log
}

cleanup() {
   docker stop $NGINX_DOCKER_TAG
   docker remove $NGINX_DOCKER_TAG

   docker compose down certbot
}

checkPortListening() {
   if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null ; then
      return 1
   else
      return 0
   fi   
}

echo '0. Generate logs files'
mkdir .log
touch .log/certbot.log
touch .log/app.log

echo '1. Pulling images'
docker pull nginx:1.23.3
docker pull alpine:3.20

echo '2. Run nginx dockerized'
docker network create main

checkPortListening 80
portOccupied=$?

if [ $portOccupied -eq 1 ]; then
   echo "Port 80 already used. Exit"

   exit 1
fi


docker run --name $NGINX_DOCKER_TAG -d -p 80:80 -v ./.nginx/bootstrap.conf:/etc/nginx/nginx.conf:ro --network main nginx:1.23.3
sleep 10

echo '3. Run certbot generate'
docker compose build certbot
docker compose up certbot

success=$?

if [$success -ne 0]; then
   echo "Error while running certbot generate command. Exit"
   rollback

   exit 1
fi

if [ -e $CERT_FILE ]
then
   echo 'Certificates generated successfully. Cleanup'
   cleanup
else
   echo 'No certificates generated. Exit'
   rollback
   exit 1
fi