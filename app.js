import dotenv  from "dotenv"
dotenv.config()
import express from "express"
const app = express()
// const creators = require("./routes/creators");
import morgan from "morgan"
import path from 'path';
import creators  from "./routes/creater.js"
const __dirname = (() => {let x = path.dirname(decodeURI(new URL(import.meta.url).pathname)); return path.resolve( (process.platform == "win32") ? x.substr(1) : x ); })();

app.use(express.static(__dirname))
let serverUrl = "/app/v1"
const PORT =   process.env.PORT || 8000;


app.use(express.json({ limit: "10mb" }));
app.use(morgan("dev"));

app.use(express.urlencoded({ extended: false }));

app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Headers", "*");

    res.setHeader("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,PATCH");

    next();
});


// app.use(`${serverUrl}/api/`, creators);

import database from "./config/database.js"


app.get("/nginx" ,async (req, res)=>{
    const [resolve] = await database.execute("SELECT  *  FROM creators")
    res.status(200).json(resolve[0])
})

app.use(creators);

app.get(serverUrl, (req, res) => {
    res.write("<h1>welcome</h1>");
    res.write("<h2>Main Page</h2>");
    res.end();
});


app.use((error, req, res, next) => {
return res.status(error.code || 401).json({ message: error.message });
});


// app.all("*", function (req, res) {
// res.status(404).json({ message: "Path Not Found" });
// });

app.listen(PORT, console.log(`server is running at http://localhost:${PORT}`));
