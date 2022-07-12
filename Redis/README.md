# Задание

Redis

Необходимо:
- сохранить большой жсон (~20МБ) в виде разных структур 
  - строка 
  - hset 
  - zset 
  - list
- протестировать скорость сохранения и чтения;
- предоставить отчет.

# Отчет

1) Берем официальный образ https://hub.docker.com/_/redis
2) Готовим датасеты
3) **Строки**
   1) `docker cp ./datasets/string.txt c974298c8904:/data/string.txt`
   2) заходим в контейнер `docker compose exec redis bash`
   3) `redis-cli < string.txt`
4) **Списки**
   1) `docker cp ./datasets/list.txt c974298c8904:/data/lists.txt`
   2) заходим в контейнер `docker compose exec redis bash`
   3) `redis-cli < lists.txt`
5) **Хэш-таблицы**
   1) `docker cp ./datasets/hset.txt c974298c8904:/data/hset.txt`
   2) заходим в контейнер `docker compose exec redis bash`
   3) `redis-cli < hset.txt`
6) **Упорядоченные множества**
   1) `docker cp ./datasets/zset.txt c974298c8904:/data/zset.txt`
   2) заходим в контейнер `docker compose exec redis bash`
   3) `redis-cli < zset.txt`
7) протестировать скорость сохранения и чтения:
   1) 
 