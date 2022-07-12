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
2) готовим докер [./docker-compose.yml](docker-compose.yml)
3) **Строки**
   1) Готовим датасет с помощью скрипта `php g_strings.php`
   2) получаем файл ~ 20Мб команд с данными такого рода:
   3) ```shell
      SET string:1 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      SET string:2 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      SET string:3 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      SET string:4 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      SET string:5 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      SET string:6 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ...
      ```
   4) копируем датасет в контейнер
   5) `docker cp ./datasets/strings.txt c974298c8904:/data/strings.txt`
   6) заходим в контейнер `docker compose exec redis bash`
   7) `time redis-cli < strings.txt`
   8) импорт занял `16.951s`
   9) читаем данные
   10) ```shell
       127.0.0.1:6379> GET string:9
       "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
       ```
4) **Списки**
   1) Готовим датасет с помощью скрипта `php g_lists.php`
   2) получаем файл ~ 20Мб команд с данными такого рода:
   3) ```shell
      RPUSH list:1 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      RPUSH list:2 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      RPUSH list:3 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      RPUSH list:4 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      RPUSH list:5 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      RPUSH list:6 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      RPUSH list:7 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ...
      ```
   4) копируем датасет в контейнер
   5) `docker cp ./datasets/lists.txt c974298c8904:/data/lists.txt`
   6) заходим в контейнер `docker compose exec redis bash`
   7) `time redis-cli < lists.txt`
   8) импорт занял `17.737s`
   9) читаем данные
   10) ```shell
       127.0.0.1:6379> LRANGE list:1 0 -1
       1) "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
       2) "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":93,\"features\":[\"powerlocks\",\"moonroof\"]}"
       ```
5) **Хэш-таблицы**
   1) Готовим датасет с помощью скрипта `php g_hsets.php`
   2) получаем файл ~ 20Мб команд с данными такого рода:
   3) ```shell
      HSET hset:1 "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof" 
      HSET hset:2 "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof"
      HSET hset:3 "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof"
      HSET hset:4 "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof"
      HSET hset:5 "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof"
      HSET hset:6 "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof"
      HSET hset:7 "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof"
      HSET hset:8 "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof"
      HSET hset:9 "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof"
      ...
      ```
   4) копируем датасет в контейнер
   5) `docker cp ./datasets/hsets.txt c974298c8904:/data/hsets.txt`
   6) заходим в контейнер `docker compose exec redis bash`
   7) `time redis-cli < hsets.txt`
   8) импорт занял `16.597s`
   9) читаем данные
   10) ```shell
       127.0.0.1:6379> HGETALL hset:1
       1) "colour"
       2) "blue"
       3) "make"
       4) "saab"
       5) "model"
       6) "93"
       7) "features"
       8) "powerlocks,moonroof"
       ```
6) **Упорядоченные множества**
   1) Готовим датасет с помощью скрипта `php g_zsets.php`
   2) получаем файл ~ 20Мб команд с данными такого рода:
   3) ```shell
      ZADD zset 1 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":1,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ZADD zset 2 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":2,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ZADD zset 3 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":3,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ZADD zset 4 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":4,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ZADD zset 5 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":5,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ZADD zset 6 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":6,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ZADD zset 7 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":7,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ZADD zset 8 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":8,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ZADD zset 9 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":9,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ZADD zset 10 "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":10,\"features\":[\"powerlocks\",\"moonroof\"]}"
      ...
      ```
   4) копируем датасет в контейнер 
   5) `docker cp ./datasets/zsets.txt c974298c8904:/data/zsets.txt`
   6) заходим в контейнер `docker compose exec redis bash`
   7) `time redis-cli < zsets.txt`
   8) импорт занял `17.796s`
   9) читаем данные
   10) ```shell
       127.0.0.1:6379> ZRANGE zset 0 2
       1) "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":1,\"features\":[\"powerlocks\",\"moonroof\"]}"
       2) "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":2,\"features\":[\"powerlocks\",\"moonroof\"]}"
       3) "{\"colour\":\"blue\",\"make\":\"saab\",\"model\":3,\"features\":[\"powerlocks\",\"moonroof\"]}"
       ```
7) протестировать скорость сохранения и чтения:
   1) тестируем скорость с разными типами данных
   2) `redis-benchmark -r 1000000 -n 2000000 -t get,set,lpush,lpop,zadd,hset -P 16 -q`
      1) ```shell
         SET: 1122964.62 requests per second, p50=0.607 msec                     
         GET: 1152073.75 requests per second, p50=0.599 msec                     
         LPUSH: 1643385.38 requests per second, p50=0.399 msec                     
         LPOP: 1584786.12 requests per second, p50=0.415 msec                     
         HSET: 1048767.75 requests per second, p50=0.679 msec                     
         ZADD: 312989.06 requests per second, p50=2.391 msec
         ```
 