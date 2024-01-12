import dotenv  from "dotenv";

dotenv.config()
import multer from "multer"


import { fileURLToPath } from 'url';
import path, { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const root_directory  =path.join(__dirname , "..")



// console.log(`${root_directory}` + process.env.WORK)



const uploadsFile = (req, res, next)=>{
    var imageName = []

    // configure storage destinationa and filename

    const storage = multer.diskStorage({
        destination :function(req, file, cb){
            cb(null, `${root_directory }` + process.env.IMAGES)
        },
        filename:function(req, file, cb){
            let image = Date.now() + file.originalname
            imageName.push(image)
            cb(null, image)
        }
    })

    const multi_upload = multer({
        storage,
        fileFilter:(req, file, cb)=>{
            if(file.mimetype == "image/png" || file.mimetype == "image/jpg" || file.mimetype =="image/jpeg"){
                cb(null, true)
            }else{
                cb(null, false);
                return next({code:401 , message:"only ['.png', '.jpg' , '.jpeg']  is allowed"})
            }
            
        }
    }).fields([
        {name:"govermentIDPicture" ,maxCount:1},
        {name:"profilePicture" ,maxCount:1} , 
        {name:"coverPicture" , maxCount:1}
    ]);


    multi_upload(req, res, function(err){
        if(err instanceof multer.MulterError){
            return next({code:401, message:err.message})
        }else if(err){
            if(err.name =="ExtensionError"){
                return next({code:413 ,message:err.message})
            }
        }else{
            return next({code:401, message:"Unknown uploading error"})
        }

        req.images = imageName
        next()
    })
}


export default uploadsFile;