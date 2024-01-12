import express from "express";
import { addBidding, addStory, allCreators, auctionTransfer, cancelFixedPriceSale, checkEmail, checkSession, checkUserName, checkWallet, directTransfer, fetchAllNfts, fetchAllNftsWithCatId, getAllCatergories,   getAllNftsData,   getSingleArt, getStories, inWalletArts, leadersboard, listOnAuction, login, makeOffer, mintArt, putOnFixedSale, signUp, singleCreator, updateCoverPhot, updateCreatorInfo, updateSalePrice, uploadProfilePicture } from "../controller/creators.js";
import fileuploads from "../config/fileUploads.js";
import uploads from "../config/nftUpload.js";
import uploadStory from "../config/uploadStory.js";
import uploadsProfile from "../config/profileUpload.js";
import uploadCover from "../config/coverUpload.js";
import uploadsNFT from "../config/nftUpload.js";
import AcceptFormdata from "../config/AcceptFormdata.js";


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


// mint router
router.post('/minArt' ,uploadsNFT ,   mintArt)
router.post("/putOnFixedPrice"  , AcceptFormdata.none() , putOnFixedSale)


router.post("/cancelFixedSale" , cancelFixedPriceSale)

router.post("/directTransfer" , AcceptFormdata.none() , directTransfer)


router.post("/updateSalePrice" , updateSalePrice);

// listed on Auctions
router.post("/listOnAuction"   , AcceptFormdata.none(), listOnAuction)
router.post('addBidding' , addBidding)



router.post('auctionTransfer' , auctionTransfer)

router.post("/makeOffer" , makeOffer)

export default router;