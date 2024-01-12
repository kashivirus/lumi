import dotenv from "dotenv"
dotenv.config()
import multer from "multer"

import { fileURLToPath } from 'url';
import path, { basename, dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const root_directory  =path.join(__dirname , "..")

const uploadStory = (req, res, next)=>{
    var imageName = [];

    const storage = multer.diskStorage({
        destination:function(req, file, cb){
            cb(null, `${root_directory}`  + process.env.STORIES)
        },
        filename:function(req, file, cb){
            let image = Date.now()  + file.originalname
            imageName.push(image);
            cb(null, image)
        }
    });

    const multi_upload = multer({
        storage,
        fileFilter :(req, file, cb)=>{
            if(file.mimetype == "image/png"  ||
            file.mimetype == "image/jpg" ||
            file.mimetype ==  "image/jpeg"){
                cb(null, true)
            }else{
                cb(null, false)
                return next({code:401, message:"only images accepted"})
            }
        }
    })
    .single("story");

    multi_upload(req , res, function(err){
        if(err instanceof multer.MulterError){
            return next({code:401, message:err.message})
        }else if (err){
            if(err.name == "ExtensionError"){
                return next({code:413 , message:err.message})
            }else{
                return next({code:401 , message:"unknon uploading error"})
            }
        }
        req.file = imageName
        next()
    })
}




export default uploadStory;