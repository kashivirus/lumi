import db from "../config/database.js"


class NFTS{
    constructor(){}

    fetchCategories(){
        return db.execute(`
        SELECT 
        cat_id AS categoryId,
        cat_name AS categoryName,
        cat_description AS categoryDescription,
        cat_img AS categoryImage,
        createdAt AS createdAt
        
        FROM categories`)
    }










    fetchNftsWithCategoryIdCount(){
        return db.execute(
            `
            SELECT
		n.*,
        c.*,
        fp.orderId, fp.tokenId as fixedPrice, fp.transactionHash as ficedHash, fp.price as fixPrice, fp.status as fixedStatus,
        ac.auctionId, ac.tokenId as aucTokenId, ac.reservePrice, ac.highestBid, ac.endTimeInSeconds, ac.highestBidder, ac.status as aucStatus,
        bd.walletAddress as bidderAddress, bd.username as bidderUsername, bd.img as bidderImage,
        cr.creatorID, cr.walletAddress, cr.username, cr.img,
        ow.creatorID as ownerId, ow.username as ownerUsername, ow.walletAddress as ownerWallet, ow.img as ownerImg
        
    
        FROM nfts n
        LEFT JOIN categories c
        ON(n.categoryId = c.cat_id )
        
        
        LEFT JOIN fixedprice fp
        ON(n.tokenId = fp.tokenId)
        
        LEFT JOIN auctions ac 
        ON (n.tokenId = ac.tokenId)
        
        LEFT JOIN creators bd 
        ON (bd.walletAddress = ac.highestBidder)
        
        
        LEFT JOIN creators cr 
        ON(cr.walletAddress = n.ownerWallet)
        
        JOIN creators ow 
        ON(ow.walletAddress = n.ownerWallet)
        WHERE
        c.cat_id = '${id}'

            `
        )
    }


    fetchNftsWithCategoryId(id, start, end){
        return db.execute(
            `
            SELECT
	n.*,
    c.*,
    fp.orderId, fp.tokenId as fixedToken, fp.transactionHash as fixedHash, fp.price as fixPrice , fp.status as fixedStatus,
    ac.auctionId, ac.tokenId as aucTokenId, ac.reservePrice, ac.highestBid, ac.endTimeInSeconds, ac.highestBidder, ac.status as aucStatus,
    bd.walletAddress as bidderAddress, bd.username as bidderUsername, bd.img as bidderImage,
    cr.creatorID, cr.walletAddress, cr.username, cr.img,
    ow.creatorID as ownerId, ow.username as ownerUsername, ow.walletAddress as ownerWallet, ow.img as ownerImg
    
    
    FROM nfts n
    LEFT JOIN categories c
    ON (n.categoryId = c.cat_id)
    
    
    LEFT JOIN fixedprice fp
    ON(n.tokenId = fp.tokenId and fp.status=1)
    
    LEFT JOIN auctions ac
    ON (n.tokenId = ac.tokenId and ac.status=1)
    
    
    LEFT JOIN creators bd
    ON (bd.walletAddress = ac.highestBidder)
    
    JOIN creators cr
    ON (cr.walletAddress = n.creatorWallet)
    
    JOIN creators ow
    ON(ow.walletAddress = n.ownerWallet)
            WHERE 
            c.cat_id = '${id}'
            LIMIT ${start}, ${end}
            `
        )
    }


    getSingleArt(tokenId){
        return db.execute(
            `
            SELECT 
        n.nft_id AS id, n.tokenId AS tokenId, n.title AS title, n.description AS description, n.image AS image,
        n.socialMediaImage AS socialMediaImage, n.artistImage as artistImage, n.titleImage as titleImage,
        n.video as video, n.sale AS sale , n.auction AS isAuction,n.fixedprice AS fixedprice , n.ownerWallet AS ownerWallet,  n.*, 
        -- isFixedPrice: rowsData.fixedprice,


        fp.orderId AS orderId ,fp.orderId as ownerId, fp.owner AS  ownerName,fp.tokenId as fixedToken,fp.transactionHash as fixedHash,
        fp.price as fixPrice,fp.status as fixedStatus,
        
        -- categories.cat_id AS categoryId,categories.cat_name AS categoryName, categories.cat_description AS categoryDescription, categories.cat_img AS 		  categoryImage, 
        
        cr.creatorID AS creatorId, cr.username AS creatorName, cr.walletAddress  AS creatorWallet,cr.img AS creatorImg,
        ow.creatorID as ownerId, ow.username as ownerUsername, ow.walletAddress as ownerWallet, ow.img as ownerImg



        FROM nfts n 
        JOIN fixedprice fp ON
        (n.tokenId = fp.tokenId AND fp.status = 1)

        JOIN creators cr 
        ON(cr.walletAddress  = n.creatorWallet)

        JOIN creators ow 
        ON(ow.walletAddress  = n.ownerWallet)
        WHERE
        n.tokenId  = ${tokenId}
            `
        )
    }



    fetchAllNftsCount() {
        return db.execute(`SELECT 
        n.*,
        cr.creatorID,cr.ratings, cr.walletAddress,cr.username,cr.img,
        ow.creatorID as ownerId, ow.username as ownerUsername, ow.walletAddress as ownerWallet, ow.img as ownerImg,
        fp.orderId,fp.tokenId as fixedToken,fp.transactionHash as fixedHash,fp.price as salePrice,fp.status as fixedStatus
        FROM  nfts n
        LEFT JOIN fixedprice fp
        ON
        (n.tokenId = fp.tokenId
          AND
        fp.status = 1)
    
    
        JOIN creators cr 
          ON
        (cr.walletAddress = n.creatorWallet)
    
        
        JOIN creators ow 
          ON
        (ow.walletAddress = n.ownerWallet)
        WHERE n.sale=1
        ORDER BY n.created_at DESC
        
         `);

}



fetchAllNfts(start, end) {
    return db.execute(`SELECT
      n.nft_id,
      MAX(n.tokenId) as tokenId,
      MAX(n.title) as title,
      MAX(n.description) as description,
      MAX(n.image) as image,
      MAX(n.sale) as sale,
      MAX(n.revenue) as revenue,
      MAX(n.auction) as auction,
      MAX(n.fixedprice) as isfixedprice,
      MAX(n.created_at) as created_at,
      MAX(cr.creatorID) as creatorID,
      MAX(cr.ratings) as ratings,
      MAX(cr.walletAddress) as creatorWallet,
      MAX(cr.username) as username,
      MAX(cr.type) as creatorType,
      MAX(cr.img) as creatorImg,
      MAX(ow.creatorID) as ownerId,
      MAX(ow.username) as ownerUsername,
      MAX(ow.walletAddress) as ownerWallet,
      MAX(ow.img) as ownerImg,
      MAX(ow.type) as ownerType,
      MAX(fp.orderId) as orderId,
      MAX(fp.transactionHash) as transactionHash,
      MAX(fp.price) as fixedprice
  FROM
      nfts n
  JOIN
      fixedprice fp ON n.tokenId = fp.tokenId AND fp.status = 1
  JOIN
      creators cr ON cr.walletAddress = n.creatorWallet
  JOIN
      creators ow ON ow.walletAddress = n.ownerWallet
  WHERE
      n.sale = 1
  GROUP BY
      n.nft_id
  
  ORDER BY
      n.created_at DESC
    LIMIT ${start}, ${end}
    
     `);
  }






    fecthAllDataFilterCount(categoryId, search){


    let catFilter = categoryId ? `AND c.cat_id = ${categoryId}` : "";
    let searchFilter = search ? `AND n.title LIKE '%${search}%' ` : "";

    
    return db.execute(`

    SELECT
    n.*,
    c.*,
    cr.creatorID, cr.walletAddress,cr.username,cr.img,
    ow.creatorID as ownerId, ow.username as ownerUsername, ow.walletAddress as ownerWallet, ow.img as ownerImg,
    fp.orderId,fp.tokenId as fixedToken,fp.transactionHash as fixedHash,fp.price as fixPrice,fp.status as fixedStatus,
    ac.auctionId,ac.tokenId as aucTokenId,ac.reservePrice,ac.highestBid,ac.endTimeInSeconds,ac.highestBidder,ac.status as aucStatus,
    bd.walletAddress as bidderAddress,bd.username as bidderUsername,bd.img as bidderImage
    FROM  nfts n
    LEFT JOIN categories c
    ON
    (n.categoryId = c.cat_id)
    LEFT JOIN fixedprice fp
    ON
    (n.tokenId = fp.tokenId
    AND
    fp.status = 1)
    LEFT JOIN auctions ac
    ON
    (n.tokenId = ac.tokenId
    AND
    ac.status = 1)
    LEFT JOIN creators bd 
    ON
    (bd.walletAddress = ac.highestBidder)
    JOIN creators cr 
    ON
    (cr.walletAddress = n.creatorWallet)
    JOIN creators ow 
    ON
    (ow.walletAddress = n.ownerWallet)
    WHERE 
        n.status = 1
    ${catFilter}
    ${searchFilter}
    ORDER BY n.created_at DESC




    `);
    }


    fetchAllDataFilter(start, end , categoryId, search){

        let catFilter = categoryId ? `AND c.cat_id =${categoryId}`:"";
        let searchFilter  = search ? `AND n.title LIKE '%${search}%'` : "";


        return db.execute(
            `
            SELECT 
            n.nft_id AS id, n.tokenId AS tokenId, n.title AS title, n.description AS description , n.image AS image, n.video AS video , n.sale AS sale ,n.auction AS isAuction,  n.fixedprice AS isFixedPrice,  n.*,
            ac.auctionId AS auctionId,ac.tokenId as aucTokenId,ac.reservePrice  AS reservePrice,ac.highestBid AS highestBid,ac.endTimeInSeconds,ac.highestBidder,ac.status as aucStatus ,
            
            
            cr.creatorID, cr.walletAddress,cr.username,cr.img, ow.creatorID as ownerId, ow.username as ownerUsername, ow.walletAddress as ownerWallet, ow.img as ownerImg,
            fp.orderId as orderId,fp.tokenId as fixedToken,fp.transactionHash as fixedHash,fp.price as fixPrice,fp.status as fixedStatus ,
            c.cat_id AS categoryId,c.cat_name AS  categoryName, c.cat_description As categoryDescription, c.cat_img AS categoryImage,
            
            bd.walletAddress as bidderAddress,bd.username as bidderUsername,bd.img as bidderImage
            FROM  nfts n
            LEFT JOIN categories c
            ON
            (n.categoryId = c.cat_id)
            LEFT JOIN fixedprice fp 
            ON
            (n.tokenId = fp.tokenId
            AND
            fp.status = 1)
            LEFT JOIN auctions ac
            ON
            (n.tokenId = ac.tokenId
            AND
            ac.status = 1)
            LEFT JOIN creators bd 
            ON
            (bd.walletAddress = ac.highestBidder)
            JOIN creators cr 
            ON
            (cr.walletAddress = n.creatorWallet)
            JOIN creators ow 
            ON
            (ow.walletAddress = n.ownerWallet)
                    WHERE 
                    n.status = 1
                        ${catFilter}
                        ${searchFilter}
                        ORDER BY n.created_at DESC
                LIMIT ${start}, ${end}
                



            `
        )

    }

    getUserByStories(){
        return db.execute(`
        SELECT 
        stories.creatorId , 
        MAX(creators.img),
        MAX(creators.username)
        
        FROM stories
        JOIN creators ON(creators.creatorID  = stories.creatorId)
        WHERE stories.status =1 AND stories.createdAt >= NOW() - INTERVAL 24 HOUR
        GROUP BY stories.creatorId;
        `)
    }

    getStories(creatorId){
        return db.execute(`SELECT stories.content, stories.createdAt
        FROM stories
        WHERE (stories.status =1)
        AND (stories.createdAt >= NOW()  - INTERVAL 24 HOUR) 
        AND (stories.creatorId = ${creatorId})
        
        `)
    }

    createdArts(walletAddress){
        return db.execute(`
        SELECT 
        n.*,
        cr.creatorID as creatorId,cr.ratings as creatorRantings, cr.walletAddress as creatorWallet,cr.username as creatorUsername,cr.img as creatorImage,
        ow.creatorID as ownerId, ow.username as ownerUsername, ow.walletAddress as ownerWallet, ow.img as ownerImage
        FROM  nfts n, creators cr, creators ow 
        WHERE
        cr.walletAddress = n.creatorWallet
        AND
        ow.walletAddress = n.ownerWallet
        AND
        n.creatorWallet = '${walletAddress}'
        ORDER BY n.nft_id DESC
        `)
    }

    collectedArts(walletAddress) {
        return db.execute(`SELECT  n.*, cr.creatorID as creatorId,cr.ratings as creatorRantings, cr.walletAddress as creatorWallet,cr.username as creatorUsername,cr.img as creatorImage, ow.creatorID as ownerId, ow.username as ownerUsername, ow.walletAddress as ownerWallet, ow.img as ownerImage
        FROM  nfts n, creators cr, creators ow 
        WHERE
        cr.walletAddress = n.creatorWallet
        AND
        ow.walletAddress = n.ownerWallet
        AND
        n.ownerWallet = '${walletAddress}'
        AND
        n.creatorWallet != '${walletAddress}'
        ORDER BY n.nft_id DESC
        `);}




        mintArt( {title, description, creatorWallet , tokenId}, image){
            return db.execute(

                `
                    INSERT INTO nfts SET
                    title = '${title}',
                    description = '${description}',
                    creatorWallet = '${creatorWallet}',
                    tokenId = '${tokenId}'
                `
            )
        }

        updateSaleprice( tokenId, orderId, price){
            return db.execute(
                `
                UPDATE fixedprice SET price = ${price}
                WHERE
                orderId = ${orderId}
                AND
                tokenId = ${tokenId}
                `
            )
        }


        putOnFixSale({orderId, tokenId, transactionsHash, ownerWallet, price}){
            return db.execute(`
                INSERT INTO fixedprice SET orderId = '${orderId}',
                tokenId =  ${tokenId},
                transactionHash = '${transactionsHash}',
                owner = '${ownerWallet}',
                price = '${price}'
            `)
        }

        updateStatusofNFTS(tokenId){
            return db.execute(`UPDATE nfts SET sale=1 , fixedPrice =1 
            WHERE tokenId=${tokenId}
            `)
        }



        cancelFixedPriceSale({ orderId, tokenId }) {
            return db.execute(`DELETE FROM fixedprice
            WHERE
            orderId = ${orderId}
            AND
            tokenId = ${tokenId}
        `);}


        resetNFTStatus(tokenId) {
            return db.execute(`UPDATE nfts SET sale = 0,fixedprice = 0
            WHERE
            tokenId = ${tokenId}
        `);
        }

        directTransfer({transferFrom , transferTo, amount, tokenId, orderId, transferHash}){
            return db.execute(`
                INSERT INTO transfernft SET transferFrom = ${transferFrom} ,
                transferTo = ${transferTo},
                amount = ${amount},
                tokenId = ${tokenId},
                transferType = 'DirectTransfer',
                tranferReferenceId = ${orderId}, 
                transferHash = ${transferHash}

            `)
        }



        updateFixedTable(tokenId, orderId){
            return db.execute(`
                UPDATE fixedprice SET onSale =0, isSold =1, status=0
                WHERE
                tokenId = ${tokenId} AND orderId =${orderId}
            `)

        }



        listOnAuctions({auctionId , tokenId, transactionsHash, ownerWallet, reservePrice}){
            const currentDate = new Date();
            const unixTimeStamp = currentDate.getTime();
            const endTime = 24  * 60  *60;
            const unixTimeStampInSeconds = Math.floor(unixTimeStamp / 1000 + endTime);

            return db.execute(`

            INSERT INTO auctions SET auctionId = ${auctionId}, 
            tokenId = ${tokenId} , 
            transactionsHash = '${transactionsHash}',
            owner_address = '${ownerWallet}',
            reservePrice = '${reservePrice}',
            endTimeInSeconds = ${unixTimeStampInSeconds}

                `)

        }


        updateStatusOfNFTtoAuction(tokenId){
            return db.execute(`UPDATE nfts SET sale=1, auction=1 
            WHERE tokenId = ${tokenId}
            `)
        }   


        updateBiddingOnAuction(
            tokenId,
            auctionId,
            highestBid,
            endTimeInSeconds,
            highestBidder
        ) {
            return db.execute(`UPDATE auctions SET highestBid = '${highestBid}' ,endTimeInSeconds = '${endTimeInSeconds}',highestBidder = '${highestBidder}'
            WHERE
            tokenId = ${tokenId}
            AND
            auctionId = ${auctionId}
        `);}



        addBidding(auctionId, highestBidder, txHash, highestBid) {
            return db.execute(`INSERT INTO biddings SET auction_id = ${auctionId}, bidder_id = '${highestBidder}', transferHash = '${txHash}', price = '${highestBid}'
        `);
        }


        auctionTransfer({
            transferFrom,
            transferTo,
            amount,
            tokenId,
            auctionId,
            transferHash,
        }) {
            return db.execute(`INSERT INTO transfernft SET transferFrom = '${transferFrom}',transferTo = '${transferTo}', amount = '${amount}',tokenId = ${tokenId},transferType = 'AuctionWon',tranferReferenceId = ${auctionId},transferHash = '${transferHash}'
        `);
        }


        resetAuctionTable(tokenId, auctionId) {
            return db.execute(`UPDATE auctions SET isSettled = 1,status = 0
            WHERE
            tokenId = ${tokenId}
            AND
            auctionId = ${auctionId}
        `);
        }


        createNotificationAuctionTransfer(transferTo, tokenId) {
            return db.execute(`INSERT INTO notifications SET recieverAddress = '${transferTo}', tokenId = ${tokenId},type = "AuctionWon"
        `);
        }


        updateOwnerAfterDirectTransfer(tokenId, transferTo) {
            return db.execute(`UPDATE nfts SET ownerWallet = '${transferTo}'
            WHERE
            tokenId = ${tokenId}
        `);}


        makeOffer({ offerId, tokenId, senderAddress, receiverAddress, offerPrice }) {
            return db.execute(`INSERT INTO offers SET offerId = ${offerId}, tokenId = ${tokenId},sender_address = '${senderAddress}',reciever_address = '${receiverAddress}', offer_price = '${offerPrice}'
        `);
        }


        offerReceivedNotification(receiverAddress, tokenId, offerId, type) {
            return db.execute(`INSERT INTO notifications SET recieverAddress = '${receiverAddress}', tokenId = ${tokenId},offerId = ${offerId}, type = '${type}'
        `);
          }

}   

export default NFTS;

