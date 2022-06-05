# Задание

Необходимо, используя туториал https://clickhouse.tech/docs/ru/getting-started/tutorial/ :
развернуть БД;
выполнить импорт тестовой БД;
выполнить несколько запросов и оценить скорость выполнения.
развернуть дополнительно одну из тестовых БД https://clickhouse.com/docs/en/getting-started/example-datasets , 
протестировать скорость запросов
развернуть Кликхаус в кластерном исполнении, создать распределенную таблицу, 
заполнить данными и протестировать скорость по сравнению с 1 инстансом Дз сдается в виде миниотчета.

# Отчет

1) берем образ [тут](https://hub.docker.com/r/clickhouse/clickhouse-server)
2) создаем [./docker-compose.yml](docker-compose.yml)
3) запускаем `docker compose up -d`
4) проверяем что все контейнеры подняты `docker compose ps`
   1) ```shell
      ```
5) 