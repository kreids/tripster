var oracle = require('oracle');
var connectData = {
    hostname: "tripsterdevdb.c487ba8vtwqs.us-east-1.rds.amazonaws.com",
    port: 1521,
    database:"TRIP",
    user: "zhangb_tripster",
    password: "iheart550",
}
/*
oracle.connect(connectData, function(err, connection) {
    if (err) { console.log("Error connecting to db:", err); return; }

    connection.execute("SELECT * FROM USERS", [], function(err, results) {
        if (err) { console.log("Error executing query:", err); return; }

        console.log(results);
        connection.close(); // call only when query is finished executing
    });
});
*/