source .env
docker-compose -f docker-compose.yml -p ${DOCKER_STACK_NAME} up -d