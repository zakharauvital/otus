rs.initiate({"_id" : "RS2", members : [{"_id" : 0, priority : 3, host : "mongo-rs2-1:27018"},{"_id" : 1, host : "mongo-rs2-2:27018"},{"_id" : 2, host : "mongo-rs2-3:27018", arbiterOnly : true}]})
