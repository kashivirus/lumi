import Creators from "../models/creators.js"
import db from "../config/database.js"
import NFTS from "../models/nfts.js";
// import joi from "Joi";
import Joi from "joi";


let creators = new Creators;
let nfts = new NFTS;



const checkSession =async(req, res, next)=>{
    
    const {wallet} = req.params
    if(!wallet){
        return next({code :400 , message:"No request Found"})
    }
    
    try {
        
        const [data] = await creators.fetchSingleWallet(wallet)
        if(data.length > 0){
            return res.status(200).json(data[0])
        }else{
            return next({code:404 , message:"User not found"})
        }
        // const fromthere = await db.execute(`SELECT * FROM creators WHERE walletAddress="${wallet}"`)
        // const [data] = fromthere
        // console.log(data[0])
        // res.send(data[0])
    } catch (error) {
        res.status(401).json({message:error})
    }
}




const checkEmail = async(req, res, next)=>{
    const  email = req.params.email


    try {
        const [result] = await creators.checkEmail(email)
        if(result.length>0){
            return res.status(409).json({walletAvailable:false})
        }else{
            return res.status(200).json({walletAvailable:true})
        }
    } catch (error) {
        return next({code :401, message:error})
    }
}


const checkWallet = async(req, res, next)=>{
    const {wallet} = req.params.wallet


    try {
        const [result] = await creators.checkWallet(wallet)

        if(result.length>0){
            return res.status(200).json({walletAvailable:true})
        }else{
            return res.status(200).json({walletAvailable:false}) 
        }
    } catch (error) {
        return next({code:404 , message:error})
    }

}



const checkUserName = async(req, res, next)=>{
    const {username} = req.params.username

    try {
        const [result] = await creators.checkusername(username);

        if(result.length >0){
            return res.status(409).json({userNameAvailable:false})
        }else{
            return res.status(200).json({userNameAvailable:true})
        }

    } catch (error) {
        return next({code:404 , message:error})
    }
}


const getAllCatergories  = async(req, res, next)=>{

    // in orignal data its push datat whihc make no sense so skipped
    try {
        const categories =[]
        const [result] = await nfts.fetchCategories();

        return res.status(200).json({categoriesData:result})
    } catch (error) {
        return next({code:404, message:"no data  found"})
    }
}


const fetchAllNftsWithCatId  = async(req, res, next) =>{
    console.log(req.params.id)
    let id = req.params.id;
    let pageNo = Number(req.query.pageNo);
    let pageCount = 8;
    let start = 0;
    let end = pageCount;
    if (pageNo) {
        if (pageNo === "1") {
        start = 0;
        end = pageCount;
        } else {
        end = pageNo * pageCount;

        start = end - pageCount;
        }
    } else {
        pageNo = 1;
    }

    try {
        const nftData = ["as"]

        // console.log("555")
        const [nftsCount] = await nfts.fetchNftsWithCategoryIdCount(id)


        let totalPages = Math.ceil((nftsCount.length-1)/pageCount)

        const [result] = await nfts.fetchNftsWithCategoryId(id, start, pageCount)

        return res.status(201).json({data:nftData})

    } catch (error) {
        return next({code:401, message:error.message})
    }
}




const getSingleArt = async(req, res, next)=>{
    let id = req.params.tokenId

    try {
        const [data] = await nfts.getSingleArt(id)
        // const {video, ...data }= data

        // if(data.nftType ==="public"){
        //     res.status(201).json({data})
        // }    

        return res.status(201).json(data);
    } catch (error) {
        return next({ code: 401, message: error });
    }
}


const fetchAllNfts = async(req, res, next)=>{
    let pageNo = Number(req.query.pageNo);
    let pageCount = 8;
    let start = 0;
    let end = pageCount;

    if (pageNo) {
        if (pageNo === "1") {
            start = 0;
            end = pageCount;
        } else {
            end = pageNo * pageCount;

            start = end - pageCount;
        }
    } else {
        pageNo = 1;
    }

    try {
        const [nftsCount] = await nfts.fetchAllNftsCount();
    
        let totalPages = Math.ceil((nftsCount.length - 1) / pageCount);
    
        const [result] = await nfts.fetchAllNfts(start, pageCount);
        if (result.length > 0) {

            return res.status(201).json({
            totalPages: totalPages,
            currentPage: pageNo,
            nftData: result,
            });
        } else {
            return next({ code: 404, message: "no data found" });
        }
        } catch (error) {
        return next({ code: 401, message: error });
    }



}



const getAllNftsData  = async(req, res, next)=>{
    let categoryId = req.query.catId;
    let search = req.query.search;
    let pageNo = Number(req.query.pageNo);
    let pageCount = 8;
    let start = 0;
    let end = pageCount;
    if (pageNo) {
        if (pageNo === "1") {
        start = 0;
        end = pageCount;
    } else {
        end = pageNo * pageCount;

        start = end - pageCount;
    }
    } else {
        pageNo = 1;
    }


    try {
        const nfdata = [];
        const [nftsCount] = await nfts.fecthAllDataFilterCount(categoryId, search)

        let totalPages = Math.ceil((nftsCount.length - 1) / pageCount);

        const [result] = await nfts.fetchAllDataFilter(start, pageCount, categoryId, search)


        if(result.length >0){
            return res.status(201).json({totalPages:totalPages, currentPage:pageNo, nfdata:result})
        }else{
            return next({code:404 , message:"no data  found"})
        }


    } catch (error) {
        return next({ code: 401, message: error });
    }
}



const getStories = async (req, res, next) => {
    try {
      const StoriesData = [];
      const [getUsersByStories] = await nfts.getUserByStories();
      if (getUsersByStories.length > 0) {
        const waiting = getUsersByStories.map(async (data) => {
          const [getStories] = await nfts.getStories(data.creatorId);
          let obj = {
            creatorId: data.creatorId,
            cratorUsername: data.username,
            creatorImg: data.img,
            stories: getStories,
          };
          StoriesData.push(obj);
        });
        Promise.all(waiting).then(() => {
          return res.status(200).json(StoriesData);
        });
      } else {
        return next({ code: 404, message: "no stories found" });
      }
    } catch (error) {
      return next({ code: 401, message: error.message });
    }
  };



const login = async(req, res, next)=>{
    let wallet = req.body.wallet
    const reqBodySchema  = Joi.object({
        wallet:Joi.string()
        .required()
        .pattern(/^0x[a-fA-F0-9]{40}$/),
    }).options({abortEarly:false, allowUnknown:false});

    const {error} = reqBodySchema.validate({wallet})
    if(error){
        res.status(401).json("Invalid wallet")
    }


    try {
        const [data] = await creators.checkWallet(wallet)
        if(data.length >0){
            return res.status(201).json(data[0])
        }else{
            res.status(404).json("wallet not found")
        }
    } catch (error) {
        return next({code:401, message:error.message})
    }
}



const allCreators = async(req,res , next)=>{
    let pageNo  = Number(req.query.pageNo)
    let pageCount  = 8;
    let start = 0
    let end  = pageCount;
    if(pageNo){
        if(pageNo ==="1"){
            start =0
            end = pageCount
        }else{
            end = pageNo * pageCount;
            start = end - pageCount
        } 
    }else{
        pageNo =1;
    }


    try {
        const creatorsInfo = [];
        const [creatosCount] = await creators.fetchAllCount()
        let totalPages = Math.ceil((creatosCount.length -1) /pageCount);

        const [result] = await creators.fetchALL(start, pageCount);

        if(result.length >0){
            return res.status(201).json({
                totalPages:totalPages, 
                currentPage:pageNo,
                creatorsInfo:result
            })
        }else{
            return next({code:404, message:"no data found"})
        }
    } catch (error) {
        return next({ code: 401, message: error });
    }
}


const singleCreator = async(req, res, next)=>{
    let username = req.params.username
    try {
        const [result] = await creators.fetchSingle(username)
        
        if(result.length > 0){
            return res.status(201).json(result[0])
        }else{
            return next({code:404, message:"no data found"})
        }
    } catch (error) {
        return next({code:401 , message:error.message})
    }
}



const leadersboard  = async(req, res, next)=>{
    
    try {
        const [topInvestor] = await creators.topInvestors();
        const [topCreators ] = await creators.topCreators();
        return res.status(200).json({topInvestor:topInvestor, topCreators:topCreators})
    } catch (error) {
        return next({code:401, message:error.message})
    }
}




const inWalletArts = async(req, res, next)=>{
    let {walletAddress} = req.params

    if(!walletAddress){
        return next({code:400, message:"no wallet address"})
    }

    try {
        const [result]  = await nfts.createdArts(walletAddress)
        const [result1] = await nfts.collectedArts(walletAddress)

        return req.status(201).json({
            createdArts:result,
            collectedArts:result1
        })
    } catch (error) {
        return next({code:401, message:error.message})
    }
}


const signUp = async(req, res ,next)=>{
    const result = await creators.signUp(req.body,req.images )

    try {
        if(result){
            return res.status(201).json({message:"Registered Successfully"})
        }else{
            return next({code:404, message:"no  data found"})
        }
        
    } catch (error) {
        return next({ code: 401, message: error });
    }

}


const addStory = async(req, res, next)=>{


    try {
        const {creatorId} = req.body
        const file = req.file


        const result = await creators.addStory(creatorId, file)

        if(result){
            res.status(201).json(creatorId, file)
        }else{
            return next({code:404, message:"Story added succesfull"})
        }
    } catch (error) {
        return next({ code: 401, message: error });
    }
}



const uploadProfilePicture = async(req, res, next)=>{

    
    const image = req.image
    let walletAddress = req.body.walletAddress
    
    
    
    try {
        if(image && walletAddress){
            const [result] = await creators.uploadProfilePic(image, walletAddress)

            res.status(202).json({message:"profile pic has been updatedd"})
        }else{
            return next({code:400, message:"no request found"})
        }
    } catch (error) {
        return next({ code: error.status, message: error.message });
    }
}




const updateCoverPhot = async(req, res, next)=>{
    

    try {
        if(req.file ==undefined){
            return next({code :400, message:"Please upload a file!"})
        }


        let walletAddress = req.body.walletAddress
        let image = req.image

        if(walletAddress && image){
            try {
                const result = await creators.updateCoverPicture(image, walletAddress)
                if(result){
                    res.status(201).json({message:"Cover Picture updated"})
                }else{
                    return next({code:404, message:"no data Found"})
                }
            } catch (error) {
                return next({code:400, message:"not request found"})
            }
        }

    } catch (error) {
        return res.status(500).json({message:`Could not upload the file :${req.file.originalname} . ${error}`})
    }
}



const updateCreatorInfo = async(req, res, next)=>{
    
    let payload =req.body;
    const {walletAddress} = payload


    if(!walletAddress){return next({code:400, message:"No request Found"})}

    try {
        const  result = await creators.updateCRINFO(payload)
        if(result){
            res.status(201).json({message:"user has been updated sucessfull"})
        }else{
            return next({ code: 404, message: "no data found" });
        }
    } catch (error) {
        return next({ code: 401, message: error });
    }
}



const mintArt = async(req, res, next)=>{
    let payload = req.body

    if(payload){
        try {
            const [result] = await nfts.mintArt(payload , req.image)

            if(result){
                return res.status(201).json({ message: " Minted Successfully" });
            }else{
                return next({ code: 404, message: "no request found" });
            }
        } catch (error) {
            return next({ code: 401, message: error });
        }
    }else{
        return next({ code: 400, message: "No Request Found" });
    }
}




const updateSalePrice = async(req, res, next)=>{
    let payload = req.body;

    if(payload){
        try {   
            const result = await nfts.updateSaleprice(payload)
            if(result){
                return res.status(201).json({message: "Sale Price Updated",
                tokenId: payload.tokenId,
                price: payload.price})
            }else{
                return next({code:404, message:"no request found"})
            }
        } catch (error) {
            return next({ code: 401, message: error });
        }
    }else{
        return next({ code: 400, message: "No Request Found" });
    }
}



const putOnFixedSale = async(req, res, next)=>{
    let payload = req.body;

    if(payload){
        try {
            const result = await nfts.putOnFixSale(payload)
            const updateStatusOfNFTS =await nfts.updateStatusofNFTS(payload.tokenId)
            if(result && updateStatusOfNFTS){
                return res.status(201).json({message:"Success" , tokenId:payload.tokenId})
            }else{
                return next({ code: 404, message: "no request found" });
            }

        } catch (error) {
            return next({ code: 401, message: error.message });
        }
    }else{
        return next({ code: 400, message: "No Request Found" });
    }
}


const cancelFixedPriceSale = async (req, res, next) => {

let payload = req.body;

if (payload) {
    try {
    const result = await nfts.cancelFixedPriceSale(payload);
    const resetListings = await nfts.resetNFTStatus(payload.tokenId);
    if (result && resetListings) {
        return res.status(201).json({
        message: "Successfully Cancelled Fixed Price Sale",
        tokenId: payload.tokenId,
        price: payload.price,
        });
    } else {
        return next({ code: 404, message: "no request found" });
    }
    } catch (error) {
    return next({ code: 401, message: error });
    }
} else {
    return next({ code: 400, message: "No Request Found" });
}
};



const directTransfer = async (req, res, next) => {
let payload = req.body;

if (payload) {
    try {
    const result = await nfts.directTransfer(payload);
    const resetListings = await nfts.resetNFTStatus(payload.tokenId);
    const updateFixedTable = await nfts.updateFixedTable(
        payload.tokenId,
        payload.orderId
    );

    const updateOwner = await nfts.updateOwnerAfterDirectTransfer(
        payload.tokenId,
        payload.transferTo
    );

    if (
        result &&
        resetListings &&
        updateFixedTable &&
        // createNotification &&
        updateOwner
    ) {
        return res.status(201).json({
        message: "NFT Transferred successfully",
        tokenId: payload.tokenId,
        });
    } else {
        return next({ code: 404, message: "no request found" });
    }
    } catch (error) {
    return next({ code: 401, message: error });
    }
} else {
    return next({ code: 400, message: "No Request Found" });
}
};


const listOnAuction = async (req, res, next) => {
 
let payload = req.body;

if (payload) {
    try {
    const result = await nfts.listOnAuction(payload);
    const updateStatusOfNFTs = await nfts.updateStatusOfNFTtoAuction(
        payload.tokenId
    );
    if (result && updateStatusOfNFTs) {
        return res.status(201).json({
        message: "Listed On Auction Successfylly",
        tokenId: payload.tokenId,
        });
    } else {
        return next({ code: 404, message: "no request found" });
    }
    } catch (error) {
    return next({ code: 401, message: error.message });
    }
} else {
    return next({ code: 400, message: "No Request Found" });
}
};


const addBidding = async (req, res, next) => {
 
let payload = req.body;

if (payload) {
try {
    const updateAuctionTable = await nfts.updateBiddingOnAuction(
    payload.tokenId,
    payload.auctionId,
    payload.highestBid,
    payload.endTimeInSeconds,
    payload.highestBidder
    );
    const result = await nfts.addBidding(
    payload.auctionId,
    payload.highestBidder,
    payload.txHash,
    payload.highestBid
    );

    if (result && updateAuctionTable) {
    return res.status(201).json({
        message: "Bidded Successfylly",
        tokenId: payload.tokenId,
    });
    } else {
    return next({ code: 404, message: "no request found" });
    }
} catch (error) {
    return next({ code: 401, message: error });
}
} else {
return next({ code: 400, message: "No Request Found" });
}
};


const auctionTransfer = async (req, res, next) => {

let payload = req.body;

if (payload) {
    try {
    const result = await nfts.auctionTransfer(payload);
    const resetListings = await nfts.resetNFTStatus(payload.tokenId);
    const updateFixedTable = await nfts.resetAuctionTable(
        payload.tokenId,
        payload.auctionId
    );
    const createNotification = await nfts.createNotificationAuctionTransfer(
        payload.transferTo,
        payload.tokenId
    );
    const updateOwner = await nfts.updateOwnerAfterDirectTransfer(
        payload.tokenId,
        payload.transferTo
    );

    if (
        result &&
        resetListings &&
        updateFixedTable &&
        createNotification &&
        updateOwner
    ) {
        return res.status(201).json({
        message: "NFT Transferred successfully",
        tokenId: payload.tokenId,
        });
    } else {
        return next({ code: 404, message: "no request found" });
    }
    } catch (error) {
    return next({ code: 401, message: error });
    }
} else {
    return next({ code: 400, message: "No Request Found" });
}
};



const makeOffer = async (req, res, next) => {

let payload = req.body;
let type = "offerReceived";
if (payload) {
    try {
    const result = await nfts.makeOffer(payload);
    const createNotification = await nfts.offerReceivedNotification(
        payload.receiverAddress,
        payload.tokenId,
        payload.offerId,
        type
    );

    if (result && createNotification) {
        return res.status(201).json({
        message: "Offer Made successfully",
        tokenId: payload.tokenId,
        offerId: payload.offerId,
        });
    } else {
        return next({ code: 404, message: "no request found" });
    }
    } catch (error) {
    return next({ code: 401, message: error });
    }
} else {
    return next({ code: 400, message: "No Request Found" });
}
};


export 
    {
        checkSession ,
        checkEmail,
        checkWallet,
        checkUserName,
        getAllCatergories,
        fetchAllNftsWithCatId,
        getSingleArt,
        fetchAllNfts,
        getAllNftsData,
        getStories,
        login,
        allCreators,
        singleCreator,
        leadersboard,
        inWalletArts,
        signUp,
        addStory,
        uploadProfilePicture,
        updateCoverPhot,
        updateCreatorInfo,
        mintArt,
        updateSalePrice,
        putOnFixedSale,
        cancelFixedPriceSale,
        directTransfer,
        listOnAuction,
        addBidding,
        auctionTransfer,
        makeOffer

    
    
    }
