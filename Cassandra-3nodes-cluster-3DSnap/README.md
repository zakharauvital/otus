# Задание

**Cassandra**

Необходимо:
- забэкапить и восстановить используя 3DSnap ваш 3 узловый Cassandra кластер;
- выбрать два на ваш вкус драйвера к Cassandra и сравнить их по производительности и потреблению ресурсов (используя "Apache Cassandra with JPA.pdf" из материралов).

# Отчет

1) Берем официальный образ [тут](https://hub.docker.com/_/cassandra)
2) готовим докер [./docker-compose.yml](docker-compose.yml)
3) Поднимаем 3-x узловой **Cassandra** кластер:
4) ```shell
   NAME                                    COMMAND                  SERVICE             STATUS              PORTS
   cassandra-3nodes-cluster-cassandra1-1   "docker-entrypoint.s…"   cassandra1          running             7000-7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp
   cassandra-3nodes-cluster-cassandra2-1   "docker-entrypoint.s…"   cassandra2          running             7000-7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp
   cassandra-3nodes-cluster-cassandra3-1   "docker-entrypoint.s…"   cassandra3          running             7000-7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp
   ```
5) выбрать два на ваш вкус драйвера к Cassandra

 