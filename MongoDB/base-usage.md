# Задание
Необходимо:

- установить MongoDB одним из способов: ВМ, докер;
- заполнить данными;
- написать несколько запросов на выборку и обновление данных 
- Сдача ДЗ осуществляется в виде миниотчета.

---

# Отчет

---

### Установка MongoDB и наполнение данными:
1) берем образ из https://hub.docker.com/_/mongo
2) запускаем образ MongoDB
   1) `docker run -itd --rm --name mongodb mongo:4.4.14-focal`
3) заходим в консоль монго
   1) `docker exec -it mongodb mongo`
4) импортируем данные в тестовую базу "test" и коллекцию "customers":
   1) скачиваем set данных из https://www.kaggle.com/datasets/shwetabh123/mall-customers  
   2) импортируем данные 
      1) `docker exec -i mongodb sh -c 'mongoimport -d test -c customers --type csv --headerline' < ./customers.csv`

---

### Поиск
   1) смотрим все документы в коллекции 
      1) `db.customers.find()`:
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b43d9"), "CustomerID" : 1, "Genre" : "Male", "Age" : 19, "Annual Income (k$)" : 15, "Spending Score (1-100)" : 39 }
            { "_id" : ObjectId("62815db1bbf41373204b43da"), "CustomerID" : 2, "Genre" : "Male", "Age" : 21, "Annual Income (k$)" : 15, "Spending Score (1-100)" : 81 }
            { "_id" : ObjectId("62815db1bbf41373204b43db"), "CustomerID" : 3, "Genre" : "Female", "Age" : 20, "Annual Income (k$)" : 16, "Spending Score (1-100)" : 6 }
            { "_id" : ObjectId("62815db1bbf41373204b43dc"), "CustomerID" : 4, "Genre" : "Female", "Age" : 23, "Annual Income (k$)" : 16, "Spending Score (1-100)" : 77 }
            { "_id" : ObjectId("62815db1bbf41373204b43dd"), "CustomerID" : 5, "Genre" : "Female", "Age" : 31, "Annual Income (k$)" : 17, "Spending Score (1-100)" : 40 }
            { "_id" : ObjectId("62815db1bbf41373204b43de"), "CustomerID" : 6, "Genre" : "Female", "Age" : 22, "Annual Income (k$)" : 17, "Spending Score (1-100)" : 76 }
            { "_id" : ObjectId("62815db1bbf41373204b43df"), "CustomerID" : 7, "Genre" : "Female", "Age" : 35, "Annual Income (k$)" : 18, "Spending Score (1-100)" : 6 }
            { "_id" : ObjectId("62815db1bbf41373204b43e0"), "CustomerID" : 8, "Genre" : "Female", "Age" : 23, "Annual Income (k$)" : 18, "Spending Score (1-100)" : 94 }
            { "_id" : ObjectId("62815db1bbf41373204b43e1"), "CustomerID" : 9, "Genre" : "Male", "Age" : 64, "Annual Income (k$)" : 19, "Spending Score (1-100)" : 3 }
            { "_id" : ObjectId("62815db1bbf41373204b43e2"), "CustomerID" : 10, "Genre" : "Female", "Age" : 30, "Annual Income (k$)" : 19, "Spending Score (1-100)" : 72 }
            { "_id" : ObjectId("62815db1bbf41373204b43e3"), "CustomerID" : 11, "Genre" : "Male", "Age" : 67, "Annual Income (k$)" : 19, "Spending Score (1-100)" : 14 }
            { "_id" : ObjectId("62815db1bbf41373204b43e4"), "CustomerID" : 12, "Genre" : "Female", "Age" : 35, "Annual Income (k$)" : 19, "Spending Score (1-100)" : 99 }
            { "_id" : ObjectId("62815db1bbf41373204b43e5"), "CustomerID" : 13, "Genre" : "Female", "Age" : 58, "Annual Income (k$)" : 20, "Spending Score (1-100)" : 15 }
            { "_id" : ObjectId("62815db1bbf41373204b43e6"), "CustomerID" : 14, "Genre" : "Female", "Age" : 24, "Annual Income (k$)" : 20, "Spending Score (1-100)" : 77 }
            { "_id" : ObjectId("62815db1bbf41373204b43e7"), "CustomerID" : 15, "Genre" : "Male", "Age" : 37, "Annual Income (k$)" : 20, "Spending Score (1-100)" : 13 }
            { "_id" : ObjectId("62815db1bbf41373204b43e8"), "CustomerID" : 16, "Genre" : "Male", "Age" : 22, "Annual Income (k$)" : 20, "Spending Score (1-100)" : 79 }
            { "_id" : ObjectId("62815db1bbf41373204b43e9"), "CustomerID" : 17, "Genre" : "Female", "Age" : 35, "Annual Income (k$)" : 21, "Spending Score (1-100)" : 35 }
            { "_id" : ObjectId("62815db1bbf41373204b43ea"), "CustomerID" : 18, "Genre" : "Male", "Age" : 20, "Annual Income (k$)" : 21, "Spending Score (1-100)" : 66 }
            { "_id" : ObjectId("62815db1bbf41373204b43eb"), "CustomerID" : 19, "Genre" : "Male", "Age" : 52, "Annual Income (k$)" : 23, "Spending Score (1-100)" : 29 }
            { "_id" : ObjectId("62815db1bbf41373204b43ec"), "CustomerID" : 20, "Genre" : "Female", "Age" : 35, "Annual Income (k$)" : 23, "Spending Score (1-100)" : 98 }
            ...
            ```
         2) с форматированием `db.customers.find().pretty()`:
            1) ```json 
                {
                  "_id" : ObjectId("62815db1bbf41373204b43d9"),
                  "CustomerID" : 1,
                  "Genre" : "Male",
                  "Age" : 19,
                  "Annual Income (k$)" : 15,
                  "Spending Score (1-100)" : 39
               }
               ...
               ```
   2) Выводим все записи относящиеся к мужчинам:
      1) `db.customers.find({"Genre": "Male"})`
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b43d9"), "CustomerID" : 1, "Genre" : "Male", "Age" : 19, "Annual Income (k$)" : 15, "Spending Score (1-100)" : 39 }
            { "_id" : ObjectId("62815db1bbf41373204b43da"), "CustomerID" : 2, "Genre" : "Male", "Age" : 21, "Annual Income (k$)" : 15, "Spending Score (1-100)" : 81 }
            { "_id" : ObjectId("62815db1bbf41373204b43e1"), "CustomerID" : 9, "Genre" : "Male", "Age" : 64, "Annual Income (k$)" : 19, "Spending Score (1-100)" : 3 }
            { "_id" : ObjectId("62815db1bbf41373204b43e3"), "CustomerID" : 11, "Genre" : "Male", "Age" : 67, "Annual Income (k$)" : 19, "Spending Score (1-100)" : 14 }
            { "_id" : ObjectId("62815db1bbf41373204b43e7"), "CustomerID" : 15, "Genre" : "Male", "Age" : 37, "Annual Income (k$)" : 20, "Spending Score (1-100)" : 13 }
            { "_id" : ObjectId("62815db1bbf41373204b43e8"), "CustomerID" : 16, "Genre" : "Male", "Age" : 22, "Annual Income (k$)" : 20, "Spending Score (1-100)" : 79 }
            { "_id" : ObjectId("62815db1bbf41373204b43ea"), "CustomerID" : 18, "Genre" : "Male", "Age" : 20, "Annual Income (k$)" : 21, "Spending Score (1-100)" : 66 }
            { "_id" : ObjectId("62815db1bbf41373204b43eb"), "CustomerID" : 19, "Genre" : "Male", "Age" : 52, "Annual Income (k$)" : 23, "Spending Score (1-100)" : 29 }
            { "_id" : ObjectId("62815db1bbf41373204b43ed"), "CustomerID" : 21, "Genre" : "Male", "Age" : 35, "Annual Income (k$)" : 24, "Spending Score (1-100)" : 35 }
            { "_id" : ObjectId("62815db1bbf41373204b43ee"), "CustomerID" : 22, "Genre" : "Male", "Age" : 25, "Annual Income (k$)" : 24, "Spending Score (1-100)" : 73 }
            { "_id" : ObjectId("62815db1bbf41373204b43f0"), "CustomerID" : 24, "Genre" : "Male", "Age" : 31, "Annual Income (k$)" : 25, "Spending Score (1-100)" : 73 }
            { "_id" : ObjectId("62815db1bbf41373204b43f1"), "CustomerID" : 26, "Genre" : "Male", "Age" : 29, "Annual Income (k$)" : 28, "Spending Score (1-100)" : 82 }
            { "_id" : ObjectId("62815db1bbf41373204b43f3"), "CustomerID" : 28, "Genre" : "Male", "Age" : 35, "Annual Income (k$)" : 28, "Spending Score (1-100)" : 61 }
            { "_id" : ObjectId("62815db1bbf41373204b43f5"), "CustomerID" : 31, "Genre" : "Male", "Age" : 60, "Annual Income (k$)" : 30, "Spending Score (1-100)" : 4 }
            { "_id" : ObjectId("62815db1bbf41373204b43f7"), "CustomerID" : 33, "Genre" : "Male", "Age" : 53, "Annual Income (k$)" : 33, "Spending Score (1-100)" : 4 }
            { "_id" : ObjectId("62815db1bbf41373204b43f8"), "CustomerID" : 34, "Genre" : "Male", "Age" : 18, "Annual Income (k$)" : 33, "Spending Score (1-100)" : 92 }
            { "_id" : ObjectId("62815db1bbf41373204b4402"), "CustomerID" : 42, "Genre" : "Male", "Age" : 24, "Annual Income (k$)" : 38, "Spending Score (1-100)" : 92 }
            { "_id" : ObjectId("62815db1bbf41373204b4409"), "CustomerID" : 43, "Genre" : "Male", "Age" : 48, "Annual Income (k$)" : 39, "Spending Score (1-100)" : 36 }
            { "_id" : ObjectId("62815db1bbf41373204b440b"), "CustomerID" : 54, "Genre" : "Male", "Age" : 59, "Annual Income (k$)" : 43, "Spending Score (1-100)" : 60 }
            { "_id" : ObjectId("62815db1bbf41373204b440d"), "CustomerID" : 52, "Genre" : "Male", "Age" : 33, "Annual Income (k$)" : 42, "Spending Score (1-100)" : 60 }
            ```
   3) мужчин с возрастом 53 года:
      1) `db.customers.find({"Genre": "Male", "Age": 53})`
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b43f7"), "CustomerID" : 33, "Genre" : "Male", "Age" : 53, "Annual Income (k$)" : 33, "Spending Score (1-100)" : 4 }
            { "_id" : ObjectId("62815db1bbf41373204b4411"), "CustomerID" : 60, "Genre" : "Male", "Age" : 53, "Annual Income (k$)" : 46, "Spending Score (1-100)" : 46 }
            ```
            
   4) мужчин с возрастом меньше 25 лет:
      1) `db.customers.find({"Genre": "Male", "Age": {$lt: 19}})`
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b43f8"), "CustomerID" : 34, "Genre" : "Male", "Age" : 18, "Annual Income (k$)" : 33, "Spending Score (1-100)" : 92 }
            { "_id" : ObjectId("62815db1bbf41373204b4417"), "CustomerID" : 66, "Genre" : "Male", "Age" : 18, "Annual Income (k$)" : 48, "Spending Score (1-100)" : 59 }
            { "_id" : ObjectId("62815db1bbf41373204b4431"), "CustomerID" : 92, "Genre" : "Male", "Age" : 18, "Annual Income (k$)" : 59, "Spending Score (1-100)" : 41 }
            ```
   5) мужчин с возрастом старше 69 лет:
      1) `db.customers.find({"Genre": "Male", "Age": {$gt: 69}})`
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b4412"), "CustomerID" : 61, "Genre" : "Male", "Age" : 70, "Annual Income (k$)" : 46, "Spending Score (1-100)" : 56 }
            { "_id" : ObjectId("62815db1bbf41373204b441c"), "CustomerID" : 71, "Genre" : "Male", "Age" : 70, "Annual Income (k$)" : 49, "Spending Score (1-100)" : 55 }
            ```
   6) мужчин возраст, которых равен 18 и 21 лет:
      1) `db.customers.find({"Genre": "Male", "Age": {$in: [21, 18]}})`
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b43da"), "CustomerID" : 2, "Genre" : "Male", "Age" : 21, "Annual Income (k$)" : 15, "Spending Score (1-100)" : 81 }
            { "_id" : ObjectId("62815db1bbf41373204b43f8"), "CustomerID" : 34, "Genre" : "Male", "Age" : 18, "Annual Income (k$)" : 33, "Spending Score (1-100)" : 92 }
            { "_id" : ObjectId("62815db1bbf41373204b4417"), "CustomerID" : 66, "Genre" : "Male", "Age" : 18, "Annual Income (k$)" : 48, "Spending Score (1-100)" : 59 }
            { "_id" : ObjectId("62815db1bbf41373204b4431"), "CustomerID" : 92, "Genre" : "Male", "Age" : 18, "Annual Income (k$)" : 59, "Spending Score (1-100)" : 41 } 
            ```
   7) возраст пол содержит подстроку "ema":
      1) `db.customers.find({"Genre": {$regex: "ema"}})`
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b43db"), "CustomerID" : 3, "Genre" : "Female", "Age" : 20, "Annual Income (k$)" : 16, "Spending Score (1-100)" : 6 }
            { "_id" : ObjectId("62815db1bbf41373204b43dc"), "CustomerID" : 4, "Genre" : "Female", "Age" : 23, "Annual Income (k$)" : 16, "Spending Score (1-100)" : 77 }
            ...
            ```
   8) покажем мужчин c "Annual Income (k$)" < 21, c лимитом 2 записи, пропуская первую запись:
      1) `db.customers.find({$and: [{"Genre": "Male"}, {"Annual Income (k$)": {$lt: 21}}]}).limit(2).skip(1)`
            1) ```shell
               { "_id" : ObjectId("62815db1bbf41373204b43da"), "CustomerID" : 2, "Genre" : "Male", "Age" : 21, "Annual Income (k$)" : 15, "Spending Score (1-100)" : 81 }
               { "_id" : ObjectId("62815db1bbf41373204b43e1"), "CustomerID" : 9, "Genre" : "Male", "Age" : 64, "Annual Income (k$)" : 19, "Spending Score (1-100)" : 3 }
               ```
   9) покажем только одно поле "Age", первых дву записи, без поля "_id":
      1) `db.customers.find({}, {"Age": 1, _id: 0}).limit(2)`
         1) ```shell
            { "Age" : 19 }
            { "Age" : 21 }
            ```

### Сортировка
1) смотрим первые 2 документа, в коллекции, с сортировкой по Age и в порядке возрастания:
   1) `db.customers.find().sort({"Age": 1}).limit(2)`:
      1) ```shell
         { "_id" : ObjectId("62815db1bbf41373204b4417"), "CustomerID" : 66, "Genre" : "Male", "Age" : 18, "Annual Income (k$)" : 48, "Spending Score (1-100)" : 59 }
         { "_id" : ObjectId("62815db1bbf41373204b43f8"), "CustomerID" : 34, "Genre" : "Male", "Age" : 18, "Annual Income (k$)" : 33, "Spending Score (1-100)" : 92 }
         ```
2) смотрим первые 2 документа, в коллекции, с сортировкой по Age и в порядке убывания:
   1) `db.customers.find().sort({"Age": -1}).limit(2)`:
      1) ```shell
         { "_id" : ObjectId("62815db1bbf41373204b441c"), "CustomerID" : 71, "Genre" : "Male", "Age" : 70, "Annual Income (k$)" : 49, "Spending Score (1-100)" : 55 }
         { "_id" : ObjectId("62815db1bbf41373204b4412"), "CustomerID" : 61, "Genre" : "Male", "Age" : 70, "Annual Income (k$)" : 46, "Spending Score (1-100)" : 56 }
         ```
---

### Индексы
1) создание индекса по полю "Age" в порядке возрастания:
   1) `db.customers.createIndex({"Age": 1})`
2) смотрим существующие индексы коллекции:
   1) `db.customers.getIndexes()`
      1) ```shell
         [{"v":2,"key":{"_id":1},"name":"_id_"},{"v":2,"key":{"Age":1},"name":"Age_1"}]
         ```
---

### Обновление
1) обновим запись с _id = "62815db1bbf41373204b441c":
   1) `db.customers.update({_id: ObjectId("62815db1bbf41373204b441c")}, {$set: {"Age" : 71}})`
      1) было `db.customers.find({_id: ObjectId("62815db1bbf41373204b441c")})`:
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b441c"), "CustomerID" : 71, "Genre" : "Male", "Age" : 70, "Annual Income (k$)" : 49, "Spending Score (1-100)" : 55 }
            ```
      2) стало `db.customers.find({_id: ObjectId("62815db1bbf41373204b441c")})`:
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b441c"), "CustomerID" : 71, "Genre" : "Male", "Age" : 71, "Annual Income (k$)" : 49, "Spending Score (1-100)" : 55 }
            ```
2) мульти-обновление по условию, для всех у кого возраст 65, сделаем 99:
   1) `db.customers.update({"Age" : 65}, {$set: {"Age" : 99}}, {multi: true})`
      1) было `db.customers.find({"Age" : 65})`:
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b4401"), "CustomerID" : 41, "Genre" : "Female", "Age" : 65, "Annual Income (k$)" : 38, "Spending Score (1-100)" : 35 }
            { "_id" : ObjectId("62815db1bbf41373204b4444"), "CustomerID" : 111, "Genre" : "Male", "Age" : 65, "Annual Income (k$)" : 63, "Spending Score (1-100)" : 52 }
            ```
      2) стало `db.customers.find({"Age" : 99})`:
         1) ```shell
            { "_id" : ObjectId("62815db1bbf41373204b4401"), "CustomerID" : 41, "Genre" : "Female", "Age" : 99, "Annual Income (k$)" : 38, "Spending Score (1-100)" : 35 }
            { "_id" : ObjectId("62815db1bbf41373204b4444"), "CustomerID" : 111, "Genre" : "Male", "Age" : 99, "Annual Income (k$)" : 63, "Spending Score (1-100)" : 52 }
            ```
3) обновление всего документа по _id = "62815db1bbf41373204b441c":
   1) было `db.customers.find({_id: ObjectId("62815db1bbf41373204b441c")})`:
      1) ```shell
         { "_id" : ObjectId("62815db1bbf41373204b441c"), "CustomerID" : 71, "Genre" : "Male", "Age" : 71, "Annual Income (k$)" : 49, "Spending Score (1-100)" : 55 }
         ```
   2) обновляем `db.customers.update({_id: ObjectId("62815db1bbf41373204b441c")}, {"NewField1" : "Hello"})`
   3) стало `db.customers.find({_id: ObjectId("62815db1bbf41373204b441c")})`:
      1) ```shell
         { "_id" : ObjectId("62815db1bbf41373204b441c"), "NewField1" : "Hello" }
         ```
---

### Удаление

1) удалим запись с _id = "62815db1bbf41373204b441c":
   1) было `db.customers.find({_id: ObjectId("62815db1bbf41373204b441c")})`:
      1) ```shell
         { "_id" : ObjectId("62815db1bbf41373204b441c"), "NewField1" : "Hello" }
         ```
   2) удаляем `db.customers.deleteOne({_id: ObjectId("62815db1bbf41373204b441c")})`
   3) стало `db.customers.find({_id: ObjectId("62815db1bbf41373204b441c")})`:
      1) ```shell
         пустой результат
         ```
2) удаление записей с условием, возраст старше 90 лет:
   1) было:
      1) ```shell
         { "_id" : ObjectId("62815db1bbf41373204b4401"), "CustomerID" : 41, "Genre" : "Female", "Age" : 99, "Annual Income (k$)" : 38, "Spending Score (1-100)" : 35 }
         { "_id" : ObjectId("62815db1bbf41373204b4444"), "CustomerID" : 111, "Genre" : "Male", "Age" : 99, "Annual Income (k$)" : 63, "Spending Score (1-100)" : 52 }
         ``` 
   2) удаляем `db.customers.deleteMany({"Age": {$gt: 90}})`
      1) ```shell
         { "acknowledged" : true, "deletedCount" : 2 }
         ```
---

### Агрегатные функции

1) количество записей с возрастом = 99:
   1) `db.customers.count({"Age": 99})`:
      1) ```shell
         2
         ```
2) количество записей, максимальный/минимальный/средний возраст с группировкой по полу:
   1) `db.customers.aggregate([{$group: {_id:"$Genre", records: {$sum: 1}, max: {$max: "$Age"}, min: {$min: "$Age"}, avg: {$avg: "$Age"}}}])`:
      1) ```shell
         { "_id" : "Male", "records" : 87, "max" : 99, "min" : 18, "avg" : 39.85057471264368 }
         { "_id" : "Female", "records" : 112, "max" : 99, "min" : 18, "avg" : 38.401785714285715 }
         ```
3) количество записей, с группировкой по полу, когда возраст старше 60 лет:
   1) `db.customers.aggregate([{$match: {"Age": {$gt: 90}}}, {$group: {_id:"$Genre", records: {$sum: 1}}}])`:
      1) ```shell
         { "_id" : "Male", "records" : 10 }
         { "_id" : "Female", "records" : 6 }
         ```

---

