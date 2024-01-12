import express from "express";
import { addStory, allCreators, checkEmail, checkSession, checkUserName, checkWallet, fetchAllNfts, fetchAllNftsWithCatId, getAllCatergories,   getAllNftsData,   getSingleArt, getStories, inWalletArts, leadersboard, login, mintArt, signUp, singleCreator, updateCoverPhot, updateCreatorInfo, updateSalePrice, uploadProfilePicture } from "../controller/creators.js";
import fileuploads from "../config/fileUploads.js";
import uploads from "../config/nftUpload.js";
import uploadStory from "../config/uploadStory.js";
import uploadsProfile from "../config/profileUpload.js";
import uploadCover from "../config/coverUpload.js";
import uploadsNFT from "../config/nftUpload.js";


const router = express.Router()



router.get("/checkSession/:wallet" , checkSession)

router.get("/checkEmail/:email" , checkEmail)
router.get("/checkWallet/:wallet" ,checkWallet)
router.get("/checkUsername/:username", checkUserName)
router.post("/signUp" , fileuploads ,  signUp)
router.post("/addStory", uploadStory, addStory)
 



//category Routes
router.get("/getCategories" , getAllCatergories)
router.get("/getCategoryArts/:id", fetchAllNftsWithCatId)      // note here pagination is involved


// art Routess

router.get("/singleArt/:tokenId", getSingleArt)    //%%%%%%%%%%%this page has 
router.get("/getArts" , fetchAllNfts )
router.get("/getNfts", getAllNftsData)
router.get("/getStories" , getStories)




router.post("/uploadProfilePicture"  ,uploadsProfile, uploadProfilePicture)
router.post("/uploadCoverPicture" , uploadCover , updateCoverPhot) 

// router.post("/login", formdata.none(), creatorController.userLogin);

router.get("/login" , login);
router.get("/allCreators" , allCreators);
router.get("/singleCreator/:username", singleCreator);
router.get("/leadersboard",leadersboard );
router.get("/inwallet" , inWalletArts)

router.post("updateInfo" , updateCreatorInfo)



router.post('/minArt' ,uploadsNFT ,   mintArt)




// router.post(
//     "/putOnFixedPrice",
//     formdata.none(),
//     creatorController.putOnFixedSale
//   );

router.post("/updateSalePrice" , updateSalePrice)





export default router;