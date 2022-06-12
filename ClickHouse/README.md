# Задание

Необходимо, используя туториал https://clickhouse.tech/docs/ru/getting-started/tutorial/ :
* развернуть БД;
* выполнить импорт тестовой БД;
* выполнить несколько запросов и оценить скорость выполнения.
* развернуть дополнительно одну из тестовых БД https://clickhouse.com/docs/en/getting-started/example-datasets , 
* протестировать скорость запросов
* развернуть Кликхаус в кластерном исполнении, создать распределенную таблицу, 
* заполнить данными и протестировать скорость по сравнению с 1 инстансом 

Дз сдается в виде миниотчета.

# Отчет

1) берем образ [тут](https://hub.docker.com/r/clickhouse/clickhouse-server)
2) создаем [./docker-compose.yml](docker-compose.yml)
3) запускаем `docker compose up -d`
4) проверяем что все контейнеры подняты `docker compose ps`
   1) ```shell
      NAME                               COMMAND             SERVICE               STATUS              PORTS
      clickhouse-clickhouse-server-1-1   "/entrypoint.sh"    clickhouse-server-1   running             0.0.0.0:9000->9000/tcp
      ```
5) выполнить импорт тестовой БД
   1) создаем БД "tutorial" 
      1) `docker compose exec clickhouse-server-1 clickhouse-client --query "CREATE DATABASE IF NOT EXISTS tutorial"`
   2) заходим в клиент и выбираем созданую БД
      1) `docker compose exec clickhouse-server-1 clickhouse-client`
   3) создаем таблицу "visits_v1":
      1) ```clickhouse
         CREATE TABLE tutorial.visits_v1
         (
            `CounterID` UInt32,
            `StartDate` Date,
            `Sign` Int8,
            `IsNew` UInt8,
            `VisitID` UInt64,
            `UserID` UInt64,
            `StartTime` DateTime,
            `Duration` UInt32,
            `UTCStartTime` DateTime,
            `PageViews` Int32,
            `Hits` Int32,
            `IsBounce` UInt8,
            `Referer` String,
            `StartURL` String,
            `RefererDomain` String,
            `StartURLDomain` String,
            `EndURL` String,
            `LinkURL` String,
            `IsDownload` UInt8,
            `TraficSourceID` Int8,
            `SearchEngineID` UInt16,
            `SearchPhrase` String,
            `AdvEngineID` UInt8,
            `PlaceID` Int32,
            `RefererCategories` Array(UInt16),
            `URLCategories` Array(UInt16),
            `URLRegions` Array(UInt32),
            `RefererRegions` Array(UInt32),
            `IsYandex` UInt8,
            `GoalReachesDepth` Int32,
            `GoalReachesURL` Int32,
            `GoalReachesAny` Int32,
            `SocialSourceNetworkID` UInt8,
            `SocialSourcePage` String,
            `MobilePhoneModel` String,
            `ClientEventTime` DateTime,
            `RegionID` UInt32,
            `ClientIP` UInt32,
            `ClientIP6` FixedString(16),
            `RemoteIP` UInt32,
            `RemoteIP6` FixedString(16),
            `IPNetworkID` UInt32,
            `SilverlightVersion3` UInt32,
            `CodeVersion` UInt32,
            `ResolutionWidth` UInt16,
            `ResolutionHeight` UInt16,
            `UserAgentMajor` UInt16,
            `UserAgentMinor` UInt16,
            `WindowClientWidth` UInt16,
            `WindowClientHeight` UInt16,
            `SilverlightVersion2` UInt8,
            `SilverlightVersion4` UInt16,
            `FlashVersion3` UInt16,
            `FlashVersion4` UInt16,
            `ClientTimeZone` Int16,
            `OS` UInt8,
            `UserAgent` UInt8,
            `ResolutionDepth` UInt8,
            `FlashMajor` UInt8,
            `FlashMinor` UInt8,
            `NetMajor` UInt8,
            `NetMinor` UInt8,
            `MobilePhone` UInt8,
            `SilverlightVersion1` UInt8,
            `Age` UInt8,
            `Sex` UInt8,
            `Income` UInt8,
            `JavaEnable` UInt8,
            `CookieEnable` UInt8,
            `JavascriptEnable` UInt8,
            `IsMobile` UInt8,
            `BrowserLanguage` UInt16,
            `BrowserCountry` UInt16,
            `Interests` UInt16,
            `Robotness` UInt8,
            `GeneralInterests` Array(UInt16),
            `Params` Array(String),
            `Goals` Nested(
               ID UInt32,
               Serial UInt32,
               EventTime DateTime,
               Price Int64,
               OrderID String,
               CurrencyID UInt32
            ),
            `WatchIDs` Array(UInt64),
            `ParamSumPrice` Int64,
            `ParamCurrency` FixedString(3),
            `ParamCurrencyID` UInt16,
            `ClickLogID` UInt64,
            `ClickEventID` Int32,
            `ClickGoodEvent` Int32,
            `ClickEventTime` DateTime,
            `ClickPriorityID` Int32,
            `ClickPhraseID` Int32,
            `ClickPageID` Int32,
            `ClickPlaceID` Int32,
            `ClickTypeID` Int32,
            `ClickResourceID` Int32,
            `ClickCost` UInt32,
            `ClickClientIP` UInt32,
            `ClickDomainID` UInt32,
            `ClickURL` String,
            `ClickAttempt` UInt8,
            `ClickOrderID` UInt32,
            `ClickBannerID` UInt32,
            `ClickMarketCategoryID` UInt32,
            `ClickMarketPP` UInt32,
            `ClickMarketCategoryName` String,
            `ClickMarketPPName` String,
            `ClickAWAPSCampaignName` String,
            `ClickPageName` String,
            `ClickTargetType` UInt16,
            `ClickTargetPhraseID` UInt64,
            `ClickContextType` UInt8,
            `ClickSelectType` Int8,
            `ClickOptions` String,
            `ClickGroupBannerID` Int32,
            `OpenstatServiceName` String,
            `OpenstatCampaignID` String,
            `OpenstatAdID` String,
            `OpenstatSourceID` String,
            `UTMSource` String,
            `UTMMedium` String,
            `UTMCampaign` String,
            `UTMContent` String,
            `UTMTerm` String,
            `FromTag` String,
            `HasGCLID` UInt8,
            `FirstVisit` DateTime,
            `PredLastVisit` Date,
            `LastVisit` Date,
            `TotalVisits` UInt32,
            `TraficSource` Nested(
                ID Int8,
                SearchEngineID UInt16,
                AdvEngineID UInt8,
                PlaceID UInt16,
                SocialSourceNetworkID UInt8,
                Domain String,
                SearchPhrase String,
                SocialSourcePage String
            ),
            `Attendance` FixedString(16),
            `CLID` UInt32,
            `YCLID` UInt64,
            `NormalizedRefererHash` UInt64,
            `SearchPhraseHash` UInt64,
            `RefererDomainHash` UInt64,
            `NormalizedStartURLHash` UInt64,
            `StartURLDomainHash` UInt64,
            `NormalizedEndURLHash` UInt64,
            `TopLevelDomain` UInt64,
            `URLScheme` UInt64,
            `OpenstatServiceNameHash` UInt64,
            `OpenstatCampaignIDHash` UInt64,
            `OpenstatAdIDHash` UInt64,
            `OpenstatSourceIDHash` UInt64,
            `UTMSourceHash` UInt64,
            `UTMMediumHash` UInt64,
            `UTMCampaignHash` UInt64,
            `UTMContentHash` UInt64,
            `UTMTermHash` UInt64,
            `FromHash` UInt64,
            `WebVisorEnabled` UInt8,
            `WebVisorActivity` UInt32,
            `ParsedParams` Nested(
                 Key1 String,
                 Key2 String,
                 Key3 String,
                 Key4 String,
                 Key5 String,
                 ValueDouble Float64
             ),
            `Market` Nested(
               Type UInt8,
               GoalID UInt32,
               OrderID String,
               OrderPrice Int64,
               PP UInt32,
               DirectPlaceID UInt32,
               DirectOrderID UInt32,
               DirectBannerID UInt32,
               GoodID String,
               GoodName String,
               GoodQuantity Int32,
               GoodPrice Int64
            ),
            `IslandID` FixedString(16)
         )
         ENGINE = CollapsingMergeTree(Sign)
         PARTITION BY toYYYYMM(StartDate)
         ORDER BY (CounterID, StartDate, intHash32(UserID), VisitID)
         SAMPLE BY intHash32(UserID)
         ```
   4) ```clickhouse
        show tables
       ┌─name──────┐
       │ visits_v1 │
       └───────────┘
      ```
   5) скачиваем тестовые данные:
   6) ```shell
      curl https://datasets.clickhouse.com/visits/tsv/visits_v1.tsv.xz | unxz --threads=`nproc` > visits_v1.tsv
      ```
   7) прокидываем `visits_v1.tsv` в контейнер:
      2) `docker cp visits_v1.tsv fe2d433f7c68:/visits_v1.tsv`
   8) импортируем в таблицы:
      1) `clickhouse-client --query "INSERT INTO tutorial.visits_v1 FORMAT TSV" --max_insert_block_size=100000 < visits_v1.tsv`
      2) проверяем успешность импорта:
         1) `clickhouse-client --query "SELECT COUNT(*) FROM tutorial.visits_v1"`
            1) `1 680 609`        
6) протестировать скорость запросов на одной ноде:
   1) запрос 
      1) ```clickhouse
          SELECT
            StartURL AS URL,
            AVG(Duration) AS AvgDuration
          FROM tutorial.visits_v1
          WHERE StartDate BETWEEN '2014-03-23' AND '2014-03-30'
          GROUP BY URL
          ORDER BY AvgDuration DESC
          LIMIT 10
         ```
      2) ```clickhouse  
         10 rows in set. Elapsed: 1.128 sec. Processed 1.47 million rows, 115.20 MB (1.31 million rows/s., 102.14 MB/s.)
         ```
7) развернуть Кликхаус в кластерном исполнении:
   1) обновим [./docker-compose.yml](docker-compose.yml) добавим 3 шарды по 1 одной реплике в каждой
      1) монтируем конфиг кластера [./config/perftest_3shards_1replicas.xml](perftest_3shards_1replicas.xml)
8) создать БД и распределенную таблицу и заполним данными:
   1) создаем БД "tutorial" на каждой ноде:
      1) `docker compose exec clickhouse-server-1 clickhouse-client --query "CREATE DATABASE IF NOT EXISTS tutorial"`
      2) `docker compose exec clickhouse-server-2 clickhouse-client --query "CREATE DATABASE IF NOT EXISTS tutorial"`
      3) `docker compose exec clickhouse-server-3 clickhouse-client --query "CREATE DATABASE IF NOT EXISTS tutorial"`
   2) создаем нужные таблицы:
      1) создаем локальную таблицу на каждой ноде (clickhouse-server-1, clickhouse-server-2, clickhouse-server-3):
         1) ```clickhouse
            CREATE TABLE tutorial.visits_local
            (
               `CounterID` UInt32,
               `StartDate` Date,
               `Sign` Int8,
               `IsNew` UInt8,
               `VisitID` UInt64,
               `UserID` UInt64,
               `StartTime` DateTime,
               `Duration` UInt32,
               `UTCStartTime` DateTime,
               `PageViews` Int32,
               `Hits` Int32,
               `IsBounce` UInt8,
               `Referer` String,
               `StartURL` String,
               `RefererDomain` String,
               `StartURLDomain` String,
               `EndURL` String,
               `LinkURL` String,
               `IsDownload` UInt8,
               `TraficSourceID` Int8,
               `SearchEngineID` UInt16,
               `SearchPhrase` String,
               `AdvEngineID` UInt8,
               `PlaceID` Int32,
               `RefererCategories` Array(UInt16),
               `URLCategories` Array(UInt16),
               `URLRegions` Array(UInt32),
               `RefererRegions` Array(UInt32),
               `IsYandex` UInt8,
               `GoalReachesDepth` Int32,
               `GoalReachesURL` Int32,
               `GoalReachesAny` Int32,
               `SocialSourceNetworkID` UInt8,
               `SocialSourcePage` String,
               `MobilePhoneModel` String,
               `ClientEventTime` DateTime,
               `RegionID` UInt32,
               `ClientIP` UInt32,
               `ClientIP6` FixedString(16),
               `RemoteIP` UInt32,
               `RemoteIP6` FixedString(16),
               `IPNetworkID` UInt32,
               `SilverlightVersion3` UInt32,
               `CodeVersion` UInt32,
               `ResolutionWidth` UInt16,
               `ResolutionHeight` UInt16,
               `UserAgentMajor` UInt16,
               `UserAgentMinor` UInt16,
               `WindowClientWidth` UInt16,
               `WindowClientHeight` UInt16,
               `SilverlightVersion2` UInt8,
               `SilverlightVersion4` UInt16,
               `FlashVersion3` UInt16,
               `FlashVersion4` UInt16,
               `ClientTimeZone` Int16,
               `OS` UInt8,
               `UserAgent` UInt8,
               `ResolutionDepth` UInt8,
               `FlashMajor` UInt8,
               `FlashMinor` UInt8,
               `NetMajor` UInt8,
               `NetMinor` UInt8,
               `MobilePhone` UInt8,
               `SilverlightVersion1` UInt8,
               `Age` UInt8,
               `Sex` UInt8,
               `Income` UInt8,
               `JavaEnable` UInt8,
               `CookieEnable` UInt8,
               `JavascriptEnable` UInt8,
               `IsMobile` UInt8,
               `BrowserLanguage` UInt16,
               `BrowserCountry` UInt16,
               `Interests` UInt16,
               `Robotness` UInt8,
               `GeneralInterests` Array(UInt16),
               `Params` Array(String),
               `Goals` Nested(
                  ID UInt32,
                  Serial UInt32,
                  EventTime DateTime,
                  Price Int64,
                  OrderID String,
                  CurrencyID UInt32
               ),
               `WatchIDs` Array(UInt64),
               `ParamSumPrice` Int64,
               `ParamCurrency` FixedString(3),
               `ParamCurrencyID` UInt16,
               `ClickLogID` UInt64,
               `ClickEventID` Int32,
               `ClickGoodEvent` Int32,
               `ClickEventTime` DateTime,
               `ClickPriorityID` Int32,
               `ClickPhraseID` Int32,
               `ClickPageID` Int32,
               `ClickPlaceID` Int32,
               `ClickTypeID` Int32,
               `ClickResourceID` Int32,
               `ClickCost` UInt32,
               `ClickClientIP` UInt32,
               `ClickDomainID` UInt32,
               `ClickURL` String,
               `ClickAttempt` UInt8,
               `ClickOrderID` UInt32,
               `ClickBannerID` UInt32,
               `ClickMarketCategoryID` UInt32,
               `ClickMarketPP` UInt32,
               `ClickMarketCategoryName` String,
               `ClickMarketPPName` String,
               `ClickAWAPSCampaignName` String,
               `ClickPageName` String,
               `ClickTargetType` UInt16,
               `ClickTargetPhraseID` UInt64,
               `ClickContextType` UInt8,
               `ClickSelectType` Int8,
               `ClickOptions` String,
               `ClickGroupBannerID` Int32,
               `OpenstatServiceName` String,
               `OpenstatCampaignID` String,
               `OpenstatAdID` String,
               `OpenstatSourceID` String,
               `UTMSource` String,
               `UTMMedium` String,
               `UTMCampaign` String,
               `UTMContent` String,
               `UTMTerm` String,
               `FromTag` String,
               `HasGCLID` UInt8,
               `FirstVisit` DateTime,
               `PredLastVisit` Date,
               `LastVisit` Date,
               `TotalVisits` UInt32,
               `TraficSource` Nested(
                   ID Int8,
                   SearchEngineID UInt16,
                   AdvEngineID UInt8,
                   PlaceID UInt16,
                   SocialSourceNetworkID UInt8,
                   Domain String,
                   SearchPhrase String,
                   SocialSourcePage String
               ),
               `Attendance` FixedString(16),
               `CLID` UInt32,
               `YCLID` UInt64,
               `NormalizedRefererHash` UInt64,
               `SearchPhraseHash` UInt64,
               `RefererDomainHash` UInt64,
               `NormalizedStartURLHash` UInt64,
               `StartURLDomainHash` UInt64,
               `NormalizedEndURLHash` UInt64,
               `TopLevelDomain` UInt64,
               `URLScheme` UInt64,
               `OpenstatServiceNameHash` UInt64,
               `OpenstatCampaignIDHash` UInt64,
               `OpenstatAdIDHash` UInt64,
               `OpenstatSourceIDHash` UInt64,
               `UTMSourceHash` UInt64,
               `UTMMediumHash` UInt64,
               `UTMCampaignHash` UInt64,
               `UTMContentHash` UInt64,
               `UTMTermHash` UInt64,
               `FromHash` UInt64,
               `WebVisorEnabled` UInt8,
               `WebVisorActivity` UInt32,
               `ParsedParams` Nested(
                    Key1 String,
                    Key2 String,
                    Key3 String,
                    Key4 String,
                    Key5 String,
                    ValueDouble Float64
                ),
               `Market` Nested(
                  Type UInt8,
                  GoalID UInt32,
                  OrderID String,
                  OrderPrice Int64,
                  PP UInt32,
                  DirectPlaceID UInt32,
                  DirectOrderID UInt32,
                  DirectBannerID UInt32,
                  GoodID String,
                  GoodName String,
                  GoodQuantity Int32,
                  GoodPrice Int64
               ),
               `IslandID` FixedString(16)
            )
            ENGINE = CollapsingMergeTree(Sign)
            PARTITION BY toYYYYMM(StartDate)
            ORDER BY (CounterID, StartDate, intHash32(UserID), VisitID)
            SAMPLE BY intHash32(UserID)
            ```
      2) создаем таблицу "visits_v1" на первой ноде (clickhouse-server-1):
         1) ```clickhouse
            CREATE TABLE tutorial.visits_v1
            (
               `CounterID` UInt32,
               `StartDate` Date,
               `Sign` Int8,
               `IsNew` UInt8,
               `VisitID` UInt64,
               `UserID` UInt64,
               `StartTime` DateTime,
               `Duration` UInt32,
               `UTCStartTime` DateTime,
               `PageViews` Int32,
               `Hits` Int32,
               `IsBounce` UInt8,
               `Referer` String,
               `StartURL` String,
               `RefererDomain` String,
               `StartURLDomain` String,
               `EndURL` String,
               `LinkURL` String,
               `IsDownload` UInt8,
               `TraficSourceID` Int8,
               `SearchEngineID` UInt16,
               `SearchPhrase` String,
               `AdvEngineID` UInt8,
               `PlaceID` Int32,
               `RefererCategories` Array(UInt16),
               `URLCategories` Array(UInt16),
               `URLRegions` Array(UInt32),
               `RefererRegions` Array(UInt32),
               `IsYandex` UInt8,
               `GoalReachesDepth` Int32,
               `GoalReachesURL` Int32,
               `GoalReachesAny` Int32,
               `SocialSourceNetworkID` UInt8,
               `SocialSourcePage` String,
               `MobilePhoneModel` String,
               `ClientEventTime` DateTime,
               `RegionID` UInt32,
               `ClientIP` UInt32,
               `ClientIP6` FixedString(16),
               `RemoteIP` UInt32,
               `RemoteIP6` FixedString(16),
               `IPNetworkID` UInt32,
               `SilverlightVersion3` UInt32,
               `CodeVersion` UInt32,
               `ResolutionWidth` UInt16,
               `ResolutionHeight` UInt16,
               `UserAgentMajor` UInt16,
               `UserAgentMinor` UInt16,
               `WindowClientWidth` UInt16,
               `WindowClientHeight` UInt16,
               `SilverlightVersion2` UInt8,
               `SilverlightVersion4` UInt16,
               `FlashVersion3` UInt16,
               `FlashVersion4` UInt16,
               `ClientTimeZone` Int16,
               `OS` UInt8,
               `UserAgent` UInt8,
               `ResolutionDepth` UInt8,
               `FlashMajor` UInt8,
               `FlashMinor` UInt8,
               `NetMajor` UInt8,
               `NetMinor` UInt8,
               `MobilePhone` UInt8,
               `SilverlightVersion1` UInt8,
               `Age` UInt8,
               `Sex` UInt8,
               `Income` UInt8,
               `JavaEnable` UInt8,
               `CookieEnable` UInt8,
               `JavascriptEnable` UInt8,
               `IsMobile` UInt8,
               `BrowserLanguage` UInt16,
               `BrowserCountry` UInt16,
               `Interests` UInt16,
               `Robotness` UInt8,
               `GeneralInterests` Array(UInt16),
               `Params` Array(String),
               `Goals` Nested(
                  ID UInt32,
                  Serial UInt32,
                  EventTime DateTime,
                  Price Int64,
                  OrderID String,
                  CurrencyID UInt32
               ),
               `WatchIDs` Array(UInt64),
               `ParamSumPrice` Int64,
               `ParamCurrency` FixedString(3),
               `ParamCurrencyID` UInt16,
               `ClickLogID` UInt64,
               `ClickEventID` Int32,
               `ClickGoodEvent` Int32,
               `ClickEventTime` DateTime,
               `ClickPriorityID` Int32,
               `ClickPhraseID` Int32,
               `ClickPageID` Int32,
               `ClickPlaceID` Int32,
               `ClickTypeID` Int32,
               `ClickResourceID` Int32,
               `ClickCost` UInt32,
               `ClickClientIP` UInt32,
               `ClickDomainID` UInt32,
               `ClickURL` String,
               `ClickAttempt` UInt8,
               `ClickOrderID` UInt32,
               `ClickBannerID` UInt32,
               `ClickMarketCategoryID` UInt32,
               `ClickMarketPP` UInt32,
               `ClickMarketCategoryName` String,
               `ClickMarketPPName` String,
               `ClickAWAPSCampaignName` String,
               `ClickPageName` String,
               `ClickTargetType` UInt16,
               `ClickTargetPhraseID` UInt64,
               `ClickContextType` UInt8,
               `ClickSelectType` Int8,
               `ClickOptions` String,
               `ClickGroupBannerID` Int32,
               `OpenstatServiceName` String,
               `OpenstatCampaignID` String,
               `OpenstatAdID` String,
               `OpenstatSourceID` String,
               `UTMSource` String,
               `UTMMedium` String,
               `UTMCampaign` String,
               `UTMContent` String,
               `UTMTerm` String,
               `FromTag` String,
               `HasGCLID` UInt8,
               `FirstVisit` DateTime,
               `PredLastVisit` Date,
               `LastVisit` Date,
               `TotalVisits` UInt32,
               `TraficSource` Nested(
                   ID Int8,
                   SearchEngineID UInt16,
                   AdvEngineID UInt8,
                   PlaceID UInt16,
                   SocialSourceNetworkID UInt8,
                   Domain String,
                   SearchPhrase String,
                   SocialSourcePage String
               ),
               `Attendance` FixedString(16),
               `CLID` UInt32,
               `YCLID` UInt64,
               `NormalizedRefererHash` UInt64,
               `SearchPhraseHash` UInt64,
               `RefererDomainHash` UInt64,
               `NormalizedStartURLHash` UInt64,
               `StartURLDomainHash` UInt64,
               `NormalizedEndURLHash` UInt64,
               `TopLevelDomain` UInt64,
               `URLScheme` UInt64,
               `OpenstatServiceNameHash` UInt64,
               `OpenstatCampaignIDHash` UInt64,
               `OpenstatAdIDHash` UInt64,
               `OpenstatSourceIDHash` UInt64,
               `UTMSourceHash` UInt64,
               `UTMMediumHash` UInt64,
               `UTMCampaignHash` UInt64,
               `UTMContentHash` UInt64,
               `UTMTermHash` UInt64,
               `FromHash` UInt64,
               `WebVisorEnabled` UInt8,
               `WebVisorActivity` UInt32,
               `ParsedParams` Nested(
                    Key1 String,
                    Key2 String,
                    Key3 String,
                    Key4 String,
                    Key5 String,
                    ValueDouble Float64
                ),
               `Market` Nested(
                  Type UInt8,
                  GoalID UInt32,
                  OrderID String,
                  OrderPrice Int64,
                  PP UInt32,
                  DirectPlaceID UInt32,
                  DirectOrderID UInt32,
                  DirectBannerID UInt32,
                  GoodID String,
                  GoodName String,
                  GoodQuantity Int32,
                  GoodPrice Int64
               ),
               `IslandID` FixedString(16)
            )
            ENGINE = CollapsingMergeTree(Sign)
            PARTITION BY toYYYYMM(StartDate)
            ORDER BY (CounterID, StartDate, intHash32(UserID), VisitID)
            SAMPLE BY intHash32(UserID)
            ```
      3) прокидываем `visits_v1.tsv` на 1-ю ноду (clickhouse-server-1):
         1) `docker cp visits_v1.tsv ea5ba7510aa3:/visits_v1.tsv`
      4) импортируем данные в таблицу tutorial.visits_v1 на 1-ой ноде (clickhouse-server-1):
         1) `clickhouse-client --query "INSERT INTO tutorial.visits_v1 FORMAT TSV" --max_insert_block_size=100000 < visits_v1.tsv`
      5) важно, чтобы ноды могли синкаться между собой, 
         1) добавим конфиг [./config/docker_related_config.xml](docker_related_config.xml)
      6) создаем распределенную таблицу `tutorial.visits_all`:
         1) ```clickhouse  
            CREATE TABLE tutorial.visits_all AS tutorial.visits_local
            ENGINE = Distributed(perftest_3shards_1replicas, tutorial, visits_local, rand());
            ```
         2) **где**:
            1) `perftest_3shards_1replicas` 
               - имя кластера в конфигурационном файле сервера: 
                 - из файла [./config/perftest_3shards_1replicas.xml](perftest_3shards_1replicas.xml)
            2) `tutorial` 
               - имя удалённой базы данных
            3) `visits_local` 
               - имя удалённой таблицы
            4) `rand()`
               - ключ шардирования
      7) вставляем данные из таблицы в распределенную таблицу на 1-ой ноде:
         1) ```clickhouse  
             ea5ba7510aa3 :) INSERT INTO tutorial.visits_all SELECT * FROM tutorial.visits_v1;
             ...
             0 rows in set. Elapsed: 83.794 sec. Processed 1.68 million rows, 2.67 GB (20.06 thousand rows/s., 31.81 MB/s.)
            ```
         2) данные будут равномерно распределены по шардам, это можно, примерно, посмотреть так:
         3) 1-ый шард:
            1) ```clickhouse  
                SELECT count(*)
                FROM tutorial.visits_local
                LIMIT 1
             
                Query id: 5ce2a13a-c672-4948-ba6c-e0f0e7d2c099
             
                ┌─count()─┐
                │  560192 │
                └─────────┘
               ```
         4) 2-ой шард:
            1) ```clickhouse  
                ...
                ┌─count()─┐
                │  559919 │
                └─────────┘
               ```
         5) 3-ый шард:
            1) ```clickhouse  
                ...
                ┌─count()─┐
                │  559170 │
                └─────────┘
               ```
         6) общее количество строк в распределенной таблице:
            1) ```clickhouse  
               SELECT count(*) FROM tutorial.visits_all LIMIT 1
               ...
               ┌─count()─┐
               │ 1679281 │
               └─────────┘     
               ```
9) протестировать скорость по сравнению с 1 инстансом:
   1) протестируем такой же запрос, как с одной нодой, но на распределенной таблице `tutorial.visits_all`:
      1) ```clickhouse
             SELECT
               StartURL AS URL,
               AVG(Duration) AS AvgDuration
             FROM tutorial.visits_all
             WHERE StartDate BETWEEN '2014-03-23' AND '2014-03-30'
             GROUP BY URL
             ORDER BY AvgDuration DESC
             LIMIT 10
         ```
      2) было:
         1) ```shell
            10 rows in set. Elapsed: 0.539 sec. Processed 1.47 million rows, 115.20 MB (2.74 million rows/s., 213.82 MB/s.)
            ```
      3) стало 
         1) ```shell  
            10 rows in set. Elapsed: 0.154 sec. Processed 1.51 million rows, 120.52 MB (9.77 million rows/s., 781.05 MB/s.)
            ```
10) **вывод**:
    - ускорение более чем в ~3 раза
11) развернуть дополнительно одну из тестовых БД [https://clickhouse.com/docs/en/getting-started/example-datasets](example-datasets) , протестировать скорость запросов
    1) возьмем набор данных [https://clickhouse.com/docs/en/getting-started/example-datasets/uk-price-paid](UK Property Price Paid)
    2) скачаем 
       1) `wget http://prod.publicdata.landregistry.gov.uk.s3-website-eu-west-1.amazonaws.com/pp-complete.csv`
    3) прокинем в контейнер первой ноды 
       1) `docker cp pp-complete.csv 1552f1dcfdd0:/pp-complete.csv`
    4) импортируем данные:
       1) ```shell
          clickhouse-local --input-format CSV --structure '
                  uuid String,
                  price UInt32,
                  time DateTime,
                  postcode String,
                  a String,
                  b String,
                  c String,
                  addr1 String,
                  addr2 String,
                  street String,
                  locality String,
                  town String,
                  district String,
                  county String,
                  d String,
                  e String
              ' --query "
              WITH splitByChar(' ', postcode) AS p
              SELECT
                  price,
                  toDate(time) AS date,
                  p[1] AS postcode1,
                  p[2] AS postcode2,
                  transform(a, ['T', 'S', 'D', 'F', 'O'], ['terraced', 'semi-detached', 'detached', 'flat', 'other']) AS type,
                  b = 'Y' AS is_new,
                  transform(c, ['F', 'L', 'U'], ['freehold', 'leasehold', 'unknown']) AS duration,
                  addr1,
                  addr2,
                  street,
                  locality,
                  town,
                  district,
                  county,
                  d = 'B' AS category
              FROM table" --date_time_input_format best_effort < pp-complete.csv | clickhouse-client --query "INSERT INTO tutorial.uk_price_paid FORMAT TSV"
          ```
    5) валидируем данные:
       1) `SELECT count() FROM uk_price_paid;`
       2) ```shell
          ┌──count()─┐
          │ 27176256 │
          └──────────┘
          ```
       3) имеем более 27 млн записей
    6) создаем на всех нодах таблицы:
       1) ```clickhouse
          CREATE TABLE uk_price_paid_local
          (
                price UInt32,
                date Date,
                postcode1 LowCardinality(String),
                postcode2 LowCardinality(String),
                type Enum8('terraced' = 1, 'semi-detached' = 2, 'detached' = 3, 'flat' = 4, 'other' = 0),
                is_new UInt8,
                duration Enum8('freehold' = 1, 'leasehold' = 2, 'unknown' = 0),
                addr1 String,
                addr2 String,
                street LowCardinality(String),
                locality LowCardinality(String),
                town LowCardinality(String),
                district LowCardinality(String),
                county LowCardinality(String),
                category UInt8
          ) ENGINE = MergeTree ORDER BY (postcode1, postcode2, addr1, addr2);
          ```
    7) создаем и импортируем в распределенную таблицу `tutorial.uk_price_paid_all`:
       1) ```clickhouse
          CREATE TABLE tutorial.uk_price_paid_all AS tutorial.uk_price_paid_local
          ENGINE = Distributed(perftest_3shards_1replicas, tutorial, uk_price_paid_local, rand());
          
          INSERT INTO tutorial.uk_price_paid_all SELECT * FROM tutorial.uk_price_paid;
          
          Elapsed: 141.749 sec. Processed 27.18 million rows, 1.30 GB (191.72 thousand rows/s., 9.17 MB/s.)
          ```
       2) на каждую шарду получается, примерно, по 9 млн записей, что в итоге дает 9 млн * 3 шарда = 27 млн записей
    8) тестируем производительность:
       1) на одной ноде `tutorial.uk_price_paid`:
          1) выполним оптимизацию:
             1) `OPTIMIZE TABLE tutorial.uk_price_paid FINAL`
          2) очищаем кеши `SYSTEM DROP MARK CACHE;`
          3) ```clickhouse
             SELECT toYear(date) AS year, round(avg(price)) AS price, bar(price, 0, 1000000, 80) 
             FROM tutorial.uk_price_paid GROUP BY year ORDER BY year;
             
             ┌─year─┬──price─┬─bar(round(avg(price)), 0, 1000000, 80)─┐
             │ 1995 │  67933 │ █████▍                                 │
             │ 1996 │  71507 │ █████▋                                 │
             │ 1997 │  78536 │ ██████▎                                │
             │ 1998 │  85439 │ ██████▋                                │
             │ 1999 │  96038 │ ███████▋                               │
             │ 2000 │ 107486 │ ████████▌                              │
             │ 2001 │ 118888 │ █████████▌                             │
             │ 2002 │ 137945 │ ███████████                            │
             │ 2003 │ 155893 │ ████████████▍                          │
             │ 2004 │ 178887 │ ██████████████▎                        │
             │ 2005 │ 189356 │ ███████████████▏                       │
             │ 2006 │ 203530 │ ████████████████▎                      │
             │ 2007 │ 219379 │ █████████████████▌                     │
             │ 2008 │ 217054 │ █████████████████▎                     │
             │ 2009 │ 213418 │ █████████████████                      │
             │ 2010 │ 236107 │ ██████████████████▊                    │
             │ 2011 │ 232803 │ ██████████████████▌                    │
             │ 2012 │ 238381 │ ███████████████████                    │
             │ 2013 │ 256923 │ ████████████████████▌                  │
             │ 2014 │ 279984 │ ██████████████████████▍                │
             │ 2015 │ 297263 │ ███████████████████████▋               │
             │ 2016 │ 313470 │ █████████████████████████              │
             │ 2017 │ 346297 │ ███████████████████████████▋           │
             │ 2018 │ 350486 │ ████████████████████████████           │
             │ 2019 │ 351985 │ ████████████████████████████▏          │
             │ 2020 │ 375697 │ ██████████████████████████████         │
             │ 2021 │ 379729 │ ██████████████████████████████▍        │
             │ 2022 │ 370402 │ █████████████████████████████▋         │
             └──────┴────────┴────────────────────────────────────────┘
             
             28 rows in set. Elapsed: 0.500 sec. Processed 27.18 million rows, 163.06 MB (54.34 million rows/s., 326.06 MB/s.)
             ```
       2) на распределенной таблице `tutorial.uk_price_paid_all`:
          1) на каждой шардированной ноде выполним:
             1) `OPTIMIZE TABLE tutorial.uk_price_paid_local FINAL`
          2) очищаем кеши `SYSTEM DROP MARK CACHE;`
          3) ```clickhouse
             
             SELECT toYear(date) AS year, round(avg(price)) AS price, bar(price, 0, 1000000, 80) 
             FROM tutorial.uk_price_paid_all GROUP BY year ORDER BY year;
             
             ┌─year─┬──price─┬─bar(round(avg(price)), 0, 1000000, 80)─┐
             │ 1995 │  67933 │ █████▍                                 │
             │ 1996 │  71507 │ █████▋                                 │
             │ 1997 │  78536 │ ██████▎                                │
             │ 1998 │  85439 │ ██████▋                                │
             │ 1999 │  96038 │ ███████▋                               │
             │ 2000 │ 107486 │ ████████▌                              │
             │ 2001 │ 118888 │ █████████▌                             │
             │ 2002 │ 137945 │ ███████████                            │
             │ 2003 │ 155893 │ ████████████▍                          │
             │ 2004 │ 178887 │ ██████████████▎                        │
             │ 2005 │ 189356 │ ███████████████▏                       │
             │ 2006 │ 203530 │ ████████████████▎                      │
             │ 2007 │ 219379 │ █████████████████▌                     │
             │ 2008 │ 217054 │ █████████████████▎                     │
             │ 2009 │ 213418 │ █████████████████                      │
             │ 2010 │ 236107 │ ██████████████████▊                    │
             │ 2011 │ 232803 │ ██████████████████▌                    │
             │ 2012 │ 238381 │ ███████████████████                    │
             │ 2013 │ 256923 │ ████████████████████▌                  │
             │ 2014 │ 279984 │ ██████████████████████▍                │
             │ 2015 │ 297263 │ ███████████████████████▋               │
             │ 2016 │ 313470 │ █████████████████████████              │
             │ 2017 │ 346297 │ ███████████████████████████▋           │
             │ 2018 │ 350486 │ ████████████████████████████           │
             │ 2019 │ 351985 │ ████████████████████████████▏          │
             │ 2020 │ 375697 │ ██████████████████████████████         │
             │ 2021 │ 379729 │ ██████████████████████████████▍        │
             │ 2022 │ 370402 │ █████████████████████████████▋         │
             └──────┴────────┴────────────────────────────────────────┘
             
             28 rows in set. Elapsed: 0.219 sec. Processed 27.18 million rows, 163.06 MB (124.35 million rows/s., 746.09 MB/s.)
             ```
    9) **вывод**:
       1) выборка на распределенной таблице в ~2,3 раза быстрее.
      