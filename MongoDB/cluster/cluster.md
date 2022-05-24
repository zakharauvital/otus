# Задание

Необходимо:
* построить шардированный кластер из 3 кластерных нод (по 3 инстанса с репликацией) и с кластером конфига(3 инстанса);
* добавить балансировку, нагрузить данными, выбрать хороший ключ шардирования, посмотреть как данные перебалансируются между шардами;
* поронять разные инстансы, посмотреть, что будет происходить, поднять обратно. Описать что произошло.
* настроить аутентификацию и многоролевой доступ; 

Формат сдачи - readme с описанием алгоритма действий, результатами и проблемами.

---

# Отчет

---

### Установка MongoDB и наполнение данными:
1) берем образ из https://hub.docker.com/_/mongo
2) создаем config-кластер MongoDB из трех нод [./docker-compose.yml](docker-compose.yml) (группа контейнеров `mongodb-cfg-*`)
3) создаем кластер из трех шард с репликацией [./docker-compose.yml](docker-compose.yml) (группа контейнеров `mongo-rs*-*`)
4) добавляем mongos (контейнер `mongos`) [./docker-compose.yml](docker-compose.yml)
5) выглядеть это будет так:
   1) ```shell
      NAME                      COMMAND                  SERVICE             STATUS              PORTS
      cluster-mongo-rs1-1-1     "docker-entrypoint.s…"   mongo-rs1-1         running             27017/tcp
      cluster-mongo-rs1-2-1     "docker-entrypoint.s…"   mongo-rs1-2         running             27017/tcp
      cluster-mongo-rs1-3-1     "docker-entrypoint.s…"   mongo-rs1-3         running             27017/tcp
      cluster-mongo-rs2-1-1     "docker-entrypoint.s…"   mongo-rs2-1         running             27017/tcp
      cluster-mongo-rs2-2-1     "docker-entrypoint.s…"   mongo-rs2-2         running             27017/tcp
      cluster-mongo-rs2-3-1     "docker-entrypoint.s…"   mongo-rs2-3         running             27017/tcp
      cluster-mongo-rs3-1-1     "docker-entrypoint.s…"   mongo-rs3-1         running             27017/tcp
      cluster-mongo-rs3-2-1     "docker-entrypoint.s…"   mongo-rs3-2         running             27017/tcp
      cluster-mongo-rs3-3-1     "docker-entrypoint.s…"   mongo-rs3-3         running             27017/tcp
      cluster-mongodb-cfg-1-1   "docker-entrypoint.s…"   mongodb-cfg-1       running             27017/tcp
      cluster-mongodb-cfg-2-1   "docker-entrypoint.s…"   mongodb-cfg-2       running             27017/tcp
      cluster-mongodb-cfg-3-1   "docker-entrypoint.s…"   mongodb-cfg-3       running             27017/tcp
      ```
6) Для инициализации конфиг-кластера, заходим на первую ноду кластера:
   1) ```shell
      docker compose exec mongodb-cfg-1 mongo --port 27019
      ```
   2) вывод `rs.status()` показывает:
      1) ```shell
         {
            "ok" : 0,
            "errmsg" : "no replset config has been received",
            "code" : 94,
            "codeName" : "NotYetInitialized",
            "$gleStats" : {
            "lastOpTime" : Timestamp(0, 0),
            "electionId" : ObjectId("000000000000000000000000")
            },
            "lastCommittedOpTime" : Timestamp(0, 0)
         }
         ```
   3) инициализируем конфиг-кластер, учитываем порт, по умолчанию, `27019`:
      1) ```shell
         rs.initiate({"_id" : "RScfg", configsvr: true, members : [{"_id" : 0, priority : 3, host : "mongodb-cfg-1:27019"},{"_id" : 1, host : "mongodb-cfg-2:27019"},{"_id" : 2, host : "mongodb-cfg-3:27019"}]})
         ```
      2) теперь вывод `rs.status()` показывает:
         1) ```json
            {
                "set" : "RScfg",
                "date" : ISODate("2022-05-22T18:52:05.210Z"),
                "myState" : 1,
                "term" : NumberLong(1),
                "syncSourceHost" : "",
                "syncSourceId" : -1,
                "configsvr" : true,
                "heartbeatIntervalMillis" : NumberLong(2000),
                "majorityVoteCount" : 2,
                "writeMajorityCount" : 2,
                "votingMembersCount" : 3,
                "writableVotingMembersCount" : 3,
                "optimes" : {
                    "lastCommittedOpTime" : {
                        "ts" : Timestamp(1653245524, 1),
                        "t" : NumberLong(1)
                    },
                    "lastCommittedWallTime" : ISODate("2022-05-22T18:52:04.521Z"),
                    "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1653245524, 1),
                        "t" : NumberLong(1)
                    },
                    "readConcernMajorityWallTime" : ISODate("2022-05-22T18:52:04.521Z"),
                    "appliedOpTime" : {
                        "ts" : Timestamp(1653245524, 1),
                        "t" : NumberLong(1)
                    },
                    "durableOpTime" : {
                        "ts" : Timestamp(1653245524, 1),
                        "t" : NumberLong(1)
                    },
                    "lastAppliedWallTime" : ISODate("2022-05-22T18:52:04.521Z"),
                    "lastDurableWallTime" : ISODate("2022-05-22T18:52:04.521Z")
                },
                "lastStableRecoveryTimestamp" : Timestamp(1653245518, 1),
                "electionCandidateMetrics" : {
                    "lastElectionReason" : "electionTimeout",
                    "lastElectionDate" : ISODate("2022-05-22T18:50:58.340Z"),
                    "electionTerm" : NumberLong(1),
                    "lastCommittedOpTimeAtElection" : {
                        "ts" : Timestamp(0, 0),
                        "t" : NumberLong(-1)
                    },
                    "lastSeenOpTimeAtElection" : {
                        "ts" : Timestamp(1653245447, 1),
                        "t" : NumberLong(-1)
                    },
                    "numVotesNeeded" : 2,
                    "priorityAtElection" : 3,
                    "electionTimeoutMillis" : NumberLong(10000),
                    "numCatchUpOps" : NumberLong(0),
                    "newTermStartDate" : ISODate("2022-05-22T18:50:58.380Z"),
                    "wMajorityWriteAvailabilityDate" : ISODate("2022-05-22T18:50:59.373Z")
                },
                "members" : [
                    {
                        "_id" : 0,
                        "name" : "mongodb-cfg-1:27019",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 852,
                        "optime" : {
                            "ts" : Timestamp(1653245524, 1),
                            "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2022-05-22T18:52:04Z"),
                        "lastAppliedWallTime" : ISODate("2022-05-22T18:52:04.521Z"),
                        "lastDurableWallTime" : ISODate("2022-05-22T18:52:04.521Z"),
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1653245458, 1),
                        "electionDate" : ISODate("2022-05-22T18:50:58Z"),
                        "configVersion" : 1,
                        "configTerm" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                    },
                    {
                        "_id" : 1,
                        "name" : "mongodb-cfg-2:27019",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 77,
                        "optime" : {
                            "ts" : Timestamp(1653245523, 1),
                            "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                            "ts" : Timestamp(1653245523, 1),
                            "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2022-05-22T18:52:03Z"),
                        "optimeDurableDate" : ISODate("2022-05-22T18:52:03Z"),
                        "lastAppliedWallTime" : ISODate("2022-05-22T18:52:04.521Z"),
                        "lastDurableWallTime" : ISODate("2022-05-22T18:52:04.521Z"),
                        "lastHeartbeat" : ISODate("2022-05-22T18:52:04.395Z"),
                        "lastHeartbeatRecv" : ISODate("2022-05-22T18:52:03.402Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-cfg-1:27019",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                    },
                    {
                        "_id" : 2,
                        "name" : "mongodb-cfg-3:27019",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 77,
                        "optime" : {
                            "ts" : Timestamp(1653245523, 1),
                            "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                            "ts" : Timestamp(1653245523, 1),
                            "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2022-05-22T18:52:03Z"),
                        "optimeDurableDate" : ISODate("2022-05-22T18:52:03Z"),
                        "lastAppliedWallTime" : ISODate("2022-05-22T18:52:04.521Z"),
                        "lastDurableWallTime" : ISODate("2022-05-22T18:52:04.521Z"),
                        "lastHeartbeat" : ISODate("2022-05-22T18:52:04.394Z"),
                        "lastHeartbeatRecv" : ISODate("2022-05-22T18:52:03.401Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncSourceHost" : "mongodb-cfg-1:27019",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 1,
                        "configTerm" : 1
                    }
                ],
                "ok" : 1,
                "$gleStats" : {
                    "lastOpTime" : Timestamp(1653245447, 1),
                    "electionId" : ObjectId("7fffffff0000000000000001")
                },
                "lastCommittedOpTime" : Timestamp(1653245524, 1),
                "$clusterTime" : {
                    "clusterTime" : Timestamp(1653245524, 1),
                    "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                    }
                },
                "operationTime" : Timestamp(1653245524, 1)
            }
            ``` 
         2) нода **mongodb-cfg-1** стала мастером:
            1) ```shell 
               "_id" : 0,
               "name" : "mongodb-cfg-1:27019",
               "stateStr" : "PRIMARY",
               ```
7) Для инициализации наших ReplicaSets, заходим на первую ноду каждого ReplicaSet (учитываем порт 27018):
   1) ```shell
      docker compose exec mongo-rs1-1 mongo --port 27018
      ```
      1) вывод `rs.status()` показывает:
         1) ```shell
            {
              ok" : 0,
              errmsg" : "no replset config has been received",
              code" : 94,
              codeName" : "NotYetInitialized"
            }
            ```
   2) инициализируем ReplicaSet 1, учитываем порт, по умолчанию, `27018`:
      1) ```shell
         rs.initiate({"_id" : "RS1", members : [{"_id" : 0, priority : 3, host : "mongo-rs1-1:27018"},{"_id" : 1, host : "mongo-rs1-2:27018"},{"_id" : 2, host : "mongo-rs1-3:27018", arbiterOnly : true}]})
         ```
      2) `mongo-rs1-1:27018` стала мастером: `PRIMARY`
   3) повторяем операции для остальных ReplicaSet 2-3 на других нодах группы, соответственно:
      1) ```shell
         docker compose exec mongo-rs2-1 mongo --port 27018
         ```
         1) ```shell
            rs.initiate({"_id" : "RS2", members : [{"_id" : 0, priority : 3, host : "mongo-rs2-1:27018"},{"_id" : 1, host : "mongo-rs2-2:27018"},{"_id" : 2, host : "mongo-rs2-3:27018", arbiterOnly : true}]})
            ```
      2) ```shell
         docker compose exec mongo-rs3-1 mongo --port 27018
         ```
         1) ```shell
            rs.initiate({"_id" : "RS3", members : [{"_id" : 0, priority : 3, host : "mongo-rs3-1:27018"},{"_id" : 1, host : "mongo-rs3-2:27018"},{"_id" : 2, host : "mongo-rs3-3:27018", arbiterOnly : true}]})
            ```
8) Конфигурируем шардированный кластер:
   1) конфигурация такая [./docker-compose.yml](docker-compose.yml):
      1) ```shell
         --configdb RScfg/mongodb-cfg-1:27019,mongodb-cfg-2:27019,mongodb-cfg-3:27019
         ```
9) Заходим в консоль **mongos**:
   1) ```shell
      docker compose exec mongos mongo
      ```
   2) добавить балансировку, добавляем три наших шарда в наш шардированный кластер:
      1) ```shell
         mongos> sh.addShard("RS1/mongo-rs1-1:27018,mongo-rs1-2:27018,mongo-rs1-3:27018")
         mongos> sh.addShard("RS2/mongo-rs2-1:27018,mongo-rs2-2:27018,mongo-rs2-3:27018")
         mongos> sh.addShard("RS3/mongo-rs3-1:27018,mongo-rs3-2:27018,mongo-rs3-3:27018")
         ```
      2) смотрим статус шардированного кластера:
         1) ```shell
            mongos> sh.status()
            --- Sharding Status ---
                sharding version: {
                        "_id" : 1,
                        "minCompatibleVersion" : 5,
                        "currentVersion" : 6,
                        "clusterId" : ObjectId("628a8612183965f01480709c")
                }
                shards:
                      {  "_id" : "RS1",  "host" : "RS1/mongo-rs1-1:27018,mongo-rs1-2:27018",  "state" : 1 }
                      {  "_id" : "RS2",  "host" : "RS2/mongo-rs2-1:27018,mongo-rs2-2:27018",  "state" : 1 }
                      {  "_id" : "RS3",  "host" : "RS3/mongo-rs3-1:27018,mongo-rs3-2:27018",  "state" : 1 }
                active mongoses:
                      "4.4.14" : 1
                autosplit:
                      Currently enabled: yes
                balancer:
                      Currently enabled:  yes
                      Currently running:  no
                      Failed balancer rounds in last 5 attempts:  0
                      Migration Results for the last 24 hours: No recent migrations
                databases:
                  {  "_id" : "config",  "primary" : "config",  "partitioned" : true }
            ```
10) нагенерим данные:
    1) устанавливаем размер чанков в 1 Мб:
       1) ```shell
          mongos> use config
          mongos> db.settings.updateOne({ _id: "chunksize" },{ $set: { _id: "chunksize", value: 1 } },{ upsert: true })
          ```
    2) включаем шардирование и наполняем данными
       1) ```shell
          mongos> use test
          mongos> sh.enableSharding("test")
          ```
    3) наполняем данными 
       1) ```shell
          mongos> use test
          mongos> for (var i=0; i<100000; i++) { db.sales.insert({name: "amount of sales", amount: Math.random()*100}) }
          mongos> db.sales.count()
          mongos> 100000
          ```
    4) создаем индекс по "amount", иначе будет ошибка "Please create an index that starts with the proposed shard key before sharding the collection": 
       1) ```shell
          mongos> db.sales.createIndex({amount: 1})
          {
              "raw" : {
                     "RS3/mongo-rs3-1:27018,mongo-rs3-2:27018,mongo-rs3-3:27018" : {
                           "createdCollectionAutomatically" : false,
                           "numIndexesBefore" : 1,
                           "numIndexesAfter" : 2,
                           "commitQuorum" : "votingMembers",
                           "ok" : 1
                     }
              },
              "ok" : 1,
              "operationTime" : Timestamp(1653250857, 27),
              "$clusterTime" : {
                     "clusterTime" : Timestamp(1653250857, 27),
                     "signature" : {
                           "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                           "keyId" : NumberLong(0)
                     }
              }
          }
          ```
    5) определим ключ шардирования:
       1) ```shell
           mongos> sh.shardCollection("test.sales", {amount: 1})
           ```
       2) началось шардирование и перераспределение данных по шардам:
          1) ```shell
             test.sales
                        shard key: { "amount" : 1 }
                        unique: false
                        balancing: true
                        chunks:
                                RS1	5
                                RS2	1
                        { "amount" : { "$minKey" : 1 } } -->> { "amount" : 16.531537936836184 } on : RS2 Timestamp(2, 0) 
                        { "amount" : 16.531537936836184 } -->> { "amount" : 32.85731117373953 } on : RS1 Timestamp(2, 1) 
                        { "amount" : 32.85731117373953 } -->> { "amount" : 49.17364389847735 } on : RS1 Timestamp(1, 2) 
                        { "amount" : 49.17364389847735 } -->> { "amount" : 65.60240643283757 } on : RS1 Timestamp(1, 3) 
                        { "amount" : 65.60240643283757 } -->> { "amount" : 81.87892342240535 } on : RS1 Timestamp(1, 4) 
                        { "amount" : 81.87892342240535 } -->> { "amount" : { "$maxKey" : 1 } } on : RS1 Timestamp(1, 5)
             ```
       3) после завершения процесса, смотрим статус шардирования:
          1) ```shell
              mongos> sh.status()
              ...
                  test.sales
                        shard key: { "amount" : 1 }
                        unique: false
                        balancing: true
                        chunks:
                                RS1	2
                                RS2	2
                                RS3	2
                        { "amount" : { "$minKey" : 1 } } -->> { "amount" : 16.531537936836184 } on : RS2 Timestamp(2, 0) 
                        { "amount" : 16.531537936836184 } -->> { "amount" : 32.85731117373953 } on : RS3 Timestamp(3, 0) 
                        { "amount" : 32.85731117373953 } -->> { "amount" : 49.17364389847735 } on : RS3 Timestamp(4, 0) 
                        { "amount" : 49.17364389847735 } -->> { "amount" : 65.60240643283757 } on : RS2 Timestamp(5, 0) 
                        { "amount" : 65.60240643283757 } -->> { "amount" : 81.87892342240535 } on : RS1 Timestamp(5, 1) 
                        { "amount" : 81.87892342240535 } -->> { "amount" : { "$maxKey" : 1 } } on : RS1 Timestamp(1, 5)
              ...
              ```
          2) **количество чанков имеет равное количество, что говорит о правильном выборе ключа шардирования**
          3) если выбрать ключ шардирования с низкой
11) поронять разные инстансы, посмотреть, что будет происходить, поднять обратно:
    1) роняем мастер первой шарды `mongo-rs1-1`:
    2) `docker compose stop mongo-rs1-1`
    3) остались следующие инстансы:
       1) ```shell
          NAME                      COMMAND                  SERVICE             STATUS              PORTS
          cluster-mongo-rs1-1-1     "docker-entrypoint.s…"   mongo-rs1-1         exited (0)          
          cluster-mongo-rs1-2-1     "docker-entrypoint.s…"   mongo-rs1-2         running             27017/tcp
          cluster-mongo-rs1-3-1     "docker-entrypoint.s…"   mongo-rs1-3         running             27017/tcp
          cluster-mongo-rs2-1-1     "docker-entrypoint.s…"   mongo-rs2-1         running             27017/tcp
          cluster-mongo-rs2-2-1     "docker-entrypoint.s…"   mongo-rs2-2         running             27017/tcp
          cluster-mongo-rs2-3-1     "docker-entrypoint.s…"   mongo-rs2-3         running             27017/tcp
          cluster-mongo-rs3-1-1     "docker-entrypoint.s…"   mongo-rs3-1         running             27017/tcp
          cluster-mongo-rs3-2-1     "docker-entrypoint.s…"   mongo-rs3-2         running             27017/tcp
          cluster-mongo-rs3-3-1     "docker-entrypoint.s…"   mongo-rs3-3         running             27017/tcp
          cluster-mongodb-cfg-1-1   "docker-entrypoint.s…"   mongodb-cfg-1       running             27017/tcp
          cluster-mongodb-cfg-2-1   "docker-entrypoint.s…"   mongodb-cfg-2       running             27017/tcp
          cluster-mongodb-cfg-3-1   "docker-entrypoint.s…"   mongodb-cfg-3       running             27017/tcp
          cluster-mongos-1          "docker-entrypoint.s…"   mongos              running             27017/tcp
          ```
    4) в результате по Raft - нода `mongo-rs1-2` стала **мастером**:
       1) ```shell
          "_id" : 1,
          "name" : "mongo-rs1-2:27018",
          "health" : 1,
          "state" : 1,
          "stateStr" : "PRIMARY",
          ```
    5) поднимаем обратно `mongo-rs1-1`:
    6) `docker compose start mongo-rs1-1`:
    7) в результате нода `mongo-rs1-1` стала **мастером**, а нода `mongo-rs1-2` стала **слейвом** обратно:
       1) ```shell
          "_id" : 0,
          "name" : "mongo-rs1-1:27018",
          "health" : 1,
          "state" : 1,
          "stateStr" : "PRIMARY",
          ```
       2) ```shell
          "_id" : 1,
          "name" : "mongo-rs1-2:27018",
          "health" : 1,
          "state" : 2,
          "stateStr" : "SECONDARY",
          ```
    8) если положить все три ноды первой шарды:
    9) `docker compose stop mongo-rs1-1 mongo-rs1-2 mongo-rs1-3`
       1) ```shell
          NAME                      COMMAND                  SERVICE             STATUS              PORTS
          cluster-mongo-rs1-1-1     "docker-entrypoint.s…"   mongo-rs1-1         exited (0)          
          cluster-mongo-rs1-2-1     "docker-entrypoint.s…"   mongo-rs1-2         exited (0)          
          cluster-mongo-rs1-3-1     "docker-entrypoint.s…"   mongo-rs1-3         exited (0)          
          cluster-mongo-rs2-1-1     "docker-entrypoint.s…"   mongo-rs2-1         running             27017/tcp
          cluster-mongo-rs2-2-1     "docker-entrypoint.s…"   mongo-rs2-2         running             27017/tcp
          cluster-mongo-rs2-3-1     "docker-entrypoint.s…"   mongo-rs2-3         running             27017/tcp
          cluster-mongo-rs3-1-1     "docker-entrypoint.s…"   mongo-rs3-1         running             27017/tcp
          cluster-mongo-rs3-2-1     "docker-entrypoint.s…"   mongo-rs3-2         running             27017/tcp
          cluster-mongo-rs3-3-1     "docker-entrypoint.s…"   mongo-rs3-3         running             27017/tcp
          cluster-mongodb-cfg-1-1   "docker-entrypoint.s…"   mongodb-cfg-1       running             27017/tcp
          cluster-mongodb-cfg-2-1   "docker-entrypoint.s…"   mongodb-cfg-2       running             27017/tcp
          cluster-mongodb-cfg-3-1   "docker-entrypoint.s…"   mongodb-cfg-3       running             27017/tcp
          cluster-mongos-1          "docker-entrypoint.s…"   mongos              running             27017/tcp
          ```
    10) при этом к части данных мы будем иметь доступ:
        1) ```shell
           mongos> db.sales.find({"amount" : 32.85731117373953})
           { "_id" : ObjectId("628d31f7b21cbd12f7df0bbd"), "name" : "amount of sales", "amount" : 32.85731117373953 }
           ```
    11) но если запросить данные из тех нод, что сейчас недоступны - будет ошибка:
        1) ```shell
           mongos> db.sales.find({ "amount" : 65.60240643283757 })
           Error: error: {
              "ok" : 0,
              "errmsg" : "Encountered non-retryable error during query :: caused by :: Could not find host matching read preference { mode: \"primary\" } for set RS1",
              "code" : 133,
              "codeName" : "FailedToSatisfyReadPreference",
              ...
           }
           ```
        2) после поднятие нод - будет доступ к данным
12) права доступа:
    1) Добавляем роль:
       1) ```shell
          db = db.getSiblingDB("admin")
          db.createRole(
            {      
               role: "superRoot",      
               privileges:[
                  { resource: {anyResource:true}, actions: ["anyAction"]}
               ],      
               roles:[]
            }
          )
          mongos> db.system.roles.find()
          { "_id" : "admin.superRoot", "role" : "superRoot", "db" : "admin", "privileges" : [ { "resource" : { "anyResource" : true }, "actions" : [ "anyAction" ] } ], "roles" : [ ] }
          ```
       2) добавляем пользователя с новой ролью:
          1) ```shell
             db.createUser({      
                user: "testUserRoleSuperRoot",      
                pwd: "pass1",      
                roles: ["superRoot"]
             })
             Successfully added user: { "user" : "testUserRoleSuperRoot", "roles" : [ "superRoot" ] }
             ```
    2) добавляем обычного пользователя:
    3) ```shell
       use admin
       db.createUser({      
         user: "user1",      
         pwd: "pass1",      
         roles: [{role: "readWrite", db: "test"}]
       })
       mongos> db.system.users.find()
       { "_id" : "admin.user1", "userId" : UUID("b1e3c8f8-3881-4172-ba11-0c014464643b"), "user" : "user1", "db" : "admin", "credentials" : { "SCRAM-SHA-1" : { "iterationCount" : 10000, "salt" : "pOY6IPNqS6w3rk9Q8fmpbg==", "storedKey" : "amnCNkDv1kc/xfTqpbXZUmem5Bc=", "serverKey" : "Y/6Xn6YZiYASzzHoH27htHXYL5c=" }, "SCRAM-SHA-256" : { "iterationCount" : 15000, "salt" : "VSk8tnXxHTXp68s4mdaQOZ1yjsWkucYNTkfmzA==", "storedKey" : "vZ5KBAxeKozOnrVyBAKLa6yS/WptPx5GsEZBBSemh1w=", "serverKey" : "tYRXbvxYDwIof0bEVYCaCK+a2X1NgEsNE03pdmXV7wU=" } }, "roles" : [ { "role" : "readWrite", "db" : "test" } ] }
       ```
    4) авторизация:
       1) ```shell
          docker compose exec mongos mongo -u user1 -p pass1 --authenticationDatabase "admin"
          ```

---

