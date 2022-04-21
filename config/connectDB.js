const mysql = require("mysql");

let connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "shops",
  port: "3306",
  multipleStatements: true,
});

// let connection = mysql.createConnection({
//   host: "167.172.74.93",
//   user: "root",
//   password: "itcmtc",
//   database: "voting",
//   port: "3307",
//   multipleStatements: true,
// });
// connection.connect();

module.exports = connection;


