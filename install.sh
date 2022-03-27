#!/bin/bash

echo -e "\033[32m#####  docker-compose-deploy-framework 安装脚本 ##### by PettyFox 2022.1.27 \033[0m"
echo -e "\033[32m#####  1. 请确保已安装docker并启用 #####\033[0m"
echo -e "\033[32m#####  2. 请确保TCP:9099端口可用 ##### \033[0m"

GOBANG_AI_SERVICE_VERSION="1.0-SNAPSHOT"

# 检测镜像
if [[ "$(docker images -q gobang-ai-service:${GOBANG_AI_SERVICE_VERSION} 2> /dev/null)" == "" ]]; then
  echo "未发现 gobang-ai-service:${GOBANG_AI_SERVICE_VERSION} 镜像，自动构建中请稍后..."

  pushd ./game-platform-backend/deploy/docker/
  chmod +x ./build.sh
  ./build.sh ${GOBANG_AI_SERVICE_VERSION}
  popd
  echo -e "\033[32m#####  gobang-ai-service:${GOBANG_AI_SERVICE_VERSION} 镜像，构建完成 ##### \033[0m"
fi

# 检测容器
if [[ "$(docker ps -a | grep gobang-ai-service 2> /dev/null)" != "" ]]; then
  echo -e "\033[31m##### 检测容器存在或运行将删除后重新创建 ##### \033[0m"
  docker stop gobang-ai-service
  docker rm gobang-ai-service
fi