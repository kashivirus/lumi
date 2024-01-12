// import multer from "multer";
// const storage  = multer.memoryStorage()
// module.exports = multer({storage:storage})


import multer from 'multer';

const storage = multer.memoryStorage();

export default multer({ storage });





// const multer = require("multer");
// const storage = multer.memoryStorage();
// // Configure multer with the storage and other options
// module.exports = multer({ storage: storage });