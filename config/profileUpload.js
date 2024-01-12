import dotenv  from "dotenv";

dotenv.config()
import multer from "multer"


import { fileURLToPath } from 'url';
import path, { basename, dirname } from 'path';
import { error } from "console";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const root_directory  =path.join(__dirname , "..")




const uploadsProfile  = (req, res, next)=>{
    var imageName = []

    const storage = multer.diskStorage({
        destination:function(req, file , cb){
            cb(null, `${root_directory}` + process.env.PROFILE_PIC_PATH)
        },
        filename:function(req, file, cb){
            imageName = Date.now() + file.originalname

            cb(null, imageName)
        }
    })

    const multi_upload = multer({
        storage, 
        limits:{fileSize:1024  * 1024 *5},
        fileFilter:(req, file, cb)=>{
            if(file.mimetype == "image/png" || file.mimetype == "image/jpg" ||file.mimetype == "image/jpeg"){
                cb(null, true)
            }else{
                cb(null, false);
                const err = new Error("only image format allowed")
                err.name = "ExtensionError"
                return cb(err)
            }
        }
    }).single("profile");


    multi_upload(req, res, function(err){
        if(err instanceof multer.MulterError){
            res.status(500)
            .send({error:{message:`multer uploading error:${err}`}})
            .end()

            return;
        }else if(err){
            if(err.name == 'ExtensionError'){
                res.status(413)
                .send({error:{message:err.message}})
                .end()
            }else{
                res.status(500)
                .send({error:{messae:`unknown uploading err : ${err}`}})
                .end()
            }
        }
    })


    req.image = imageName
    next()



}

export default uploadsProfile;