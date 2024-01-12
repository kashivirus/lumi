import db from "../config/database.js"



class Creators{
    constructor(){}



    fetchSingleWallet(wallet){
        return db.execute(`SELECT * FROM creators WHERE walletAddress='${wallet}'`)
    }


    checkEmail(email){
        return db.execute(`SELECT * FROM  creators WHERE email='${email}'`)
    }


    checkWallet(wallet){
        return db.execute(`SELECT * FROM creators WHERE walletAddress  = '${wallet}'`)
    }

    checkusername(username){
        return db.execute(`SELECT * FROM creators WHERE username = '${username}'`)
    }

    fetchAllCount(){
        return db.execute(`SELECT * FROM creators;
        `);
    }


    fetchALL(start, end){
        return db.execute(`


        SELECT 
            c.creatorID AS creatorId ,
            c.username AS username, 
            c.firstName AS firstName, 
            c.lastName AS lastName, 
            c.walletAddress AS walletAddress, 
            c.img AS image, 
            c.cover AS cover, 
            c.bio AS bio,
            c.email AS email, 
            c.portfolio AS portfolio, 
            c.instagram AS instagram, 
            c.twitter AS twitter,
            c.facebook As facebook, 
            c.createdAt AS createdAt
            FROM creators c LIMIT ${start} , ${end}`)
    }

    fetchSingle(username){
        return db.execute(`SELECT * FROM creators WHERE username = '${username}'`)
    }

    topInvestors() {
        return db.execute(
        `SELECT creators.username, creators.img, creators.ratings ,
        SUM(transactions.amount) AS total_amount FROM creators JOIN transactions ON transactions.recievedTo = creators.walletAddress GROUP BY creators.username, creators.img, creators.ratings ORDER BY total_amount DESC`
        );
    }


    topCreators() {
        return db.execute(
        `
        SELECT creators.username, creators.img, creators.ratings , SUM(transactions.amount) AS total_amount 
        FROM creators JOIN transactions ON transactions.sendedFrom = creators.walletAddress
        GROUP BY creators.username, creators.img, creators.ratings 
        ORDER BY total_amount DESC
        `
        );}


    signUp({username, gender, email, country, govermentID, type, walllet}  , err){
        return db.execute(
            `
                INSERT INTO creators set 
                username = '${username}',
                gender = '${gender}',
                email = '${email}', 
                country = '${country}',
                govermentID = '${govermentID}',
                govermentIDPicture = '${arr[0]}',
                img = '${arr[1]}',
                cover = '${arr[2]}',
                type = '${type}',
                walletAddress  = '${wallet}'
            `
        )
    }


    addStory(creatorId, file){
        return db.execute(`
            INSERT INTO creator SET content = ${file} ,creatorId  = ${creatorId} 
        `)
    }


    uploadProfilePic(image, walletAddress){
        return db.execute(
            `
                UPDATE creators SET img = ${image}
                WHERE 
                walletAddress = ${walletAddress}
            `   
        )
    }



    updateCoverPicture(image,walletAddress ){
        return db.execute(`
            UPDATE creators SET cover=${image}
            WHERE walletAddress = ${walletAddress}
            `)
    }



    updateCRINFO(walletAddress, username, bio, instagram, discord , twitter, linkdin){
        return db.execute(
            `
                UPDATE creators SET username = '${username}', bio = '${bio}' , instagram = '${instagram}' , discord = '${discord} , 
                twitter = ${twitter} , linkdin = ${linkdin}
                WHERE 
                walletAddress = ${walletAddress}

                `
        )
    }


    resetAuctionTable(tokenId, auctionId) {
        return db.execute(`UPDATE auctions SET isSettled = 1,status = 0
        WHERE
        tokenId = ${tokenId}
        AND
        auctionId = ${auctionId}
    `);
      }


}
export default Creators;