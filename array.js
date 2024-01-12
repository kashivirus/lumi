document.getElementById("hello");
{
console.log("hello")

const db = require("./config/database")

function dbv(){
    return db.execute(`SELECT * FROM creators;`)
}

dbv()


}