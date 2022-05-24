rs.initiate({"_id" : "RS3", members : [{"_id" : 0, priority : 3, host : "mongo-rs3-1:27018"},{"_id" : 1, host : "mongo-rs3-2:27018"},{"_id" : 2, host : "mongo-rs3-3:27018", arbiterOnly : true}]})
