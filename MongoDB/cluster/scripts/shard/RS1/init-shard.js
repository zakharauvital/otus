rs.initiate({"_id" : "RS1", members : [{"_id" : 0, priority : 3, host : "mongo-rs1-1:27018"},{"_id" : 1, host : "mongo-rs1-2:27018"},{"_id" : 2, host : "mongo-rs1-3:27018", arbiterOnly : true}]})
