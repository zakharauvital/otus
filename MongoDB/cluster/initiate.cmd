docker compose exec mongodb-cfg-1 mongo --port 27019

rs.initiate({"_id" : "RScfg", configsvr: true, members : [{"_id" : 0, priority : 3, host : "mongodb-cfg-1:27019"},{"_id" : 1, host : "mongodb-cfg-2:27019"},{"_id" : 2, host : "mongodb-cfg-3:27019"}]})


docker compose exec mongo-rs1-1 mongo --port 27018

rs.initiate({"_id" : "RS1", members : [{"_id" : 0, priority : 3, host : "mongo-rs1-1:27018"},{"_id" : 1, host : "mongo-rs1-2:27018"},{"_id" : 2, host : "mongo-rs1-3:27018", arbiterOnly : true}]})


docker compose exec mongo-rs2-1 mongo --port 27018

rs.initiate({"_id" : "RS2", members : [{"_id" : 0, priority : 3, host : "mongo-rs2-1:27018"},{"_id" : 1, host : "mongo-rs2-2:27018"},{"_id" : 2, host : "mongo-rs2-3:27018", arbiterOnly : true}]})


docker compose exec mongo-rs3-1 mongo --port 27018

rs.initiate({"_id" : "RS3", members : [{"_id" : 0, priority : 3, host : "mongo-rs3-1:27018"},{"_id" : 1, host : "mongo-rs3-2:27018"},{"_id" : 2, host : "mongo-rs3-3:27018", arbiterOnly : true}]})


docker compose exec mongos mongo

sh.addShard("RS1/mongo-rs1-1:27018,mongo-rs1-2:27018,mongo-rs1-3:27018")
sh.addShard("RS2/mongo-rs2-1:27018,mongo-rs2-2:27018,mongo-rs2-3:27018")
sh.addShard("RS3/mongo-rs3-1:27018,mongo-rs3-2:27018,mongo-rs3-3:27018")


for (var i=0; i<100000; i++) { db.sales.insert({name: "amount of sales", amount: i}) }
for (var i=0; i<10; i++) { db.sales2.insert({name: "amount of sales", amount: i}) }

db.createUser({
         user: "user2",
         pwd: "pass2",
         roles: [{role: "readWrite", db: "test"}]
})