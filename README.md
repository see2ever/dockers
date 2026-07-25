# DOCKER

基于 `Linux` 内核的 `cgroups` 和 `namespace` 特性，打造的容器平台。

## Dockerfile

定义镜像长什么样子，里面有什么包

## compose.yaml

编排镜像该如何挂载

## 命令简介

```bash
# 修改了 Dockerfile 或依赖，重新构建
docker compose build

# 正式跑起来
docker compose up -d

# 看看跑没跑
docker ps

# 进去排查问题
docker exec -u root -it 容器名 /bin/bash

# 临时跑个一次性任务
docker compose run --rm 服务名 npm test

# 磁盘不够了，清理
docker system df
docker system prune -af ## 完全清理需要加上 --volumn，把宿主机的存储卷也删了
```
