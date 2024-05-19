const { ethers } = require("hardhat");
async function main() {
    const Final_Collection = await ethers.getContractFactory("MyFinalCollection");
    const final = await Final_Collection.deploy(
        "finalCollection", 
        "MCC",
        "https://ipfs.io/ipfs/QmTT5CqWZwvmHBKphnLvNfr7EDLvbPGHbrALEP4sG1d3KJ/");

    await final.deployed();

    console.log("Successfully deployed smart contract to:", final.address);

    await final.mint(10);//1
    const uri1 = await final.uri(1);
    await final.mint(10);//2
    const uri2 = await final.uri(2);
    await final.mint(10);//3
    const uri3 = await final.uri(3);
    await final.mint(10);//4
    const uri4 = await final.uri(4);

    await final.mint(20);//5
    const uri5 = await final.uri(5);
    await final.mint(20);//6
    const uri6 = await final.uri(6);
    await final.mint(20);//7
    const uri7 = await final.uri(7);

    await final.mint(3);//8
    const uri8 = await final.uri(8);

    await final.mint(1);//9
    const uri9 = await final.uri(9);
    await final.mint(1);//10
    const uri10 = await final.uri(10);

    console.log("NFT successfully minted");
    console.log(
        `1: ${uri1}
        2: ${uri2}
        3: ${uri3}
        4: ${uri4}
        5: ${uri5}
        6: ${uri6}
        7: ${uri7}
        8: ${uri8}
        9: ${uri9}
        10: ${uri10}`)
}

main().then(() => process.exit(0))
    .catch(err => {
        console.error(err);
        process.exit(1)
    });
//0x7f39bAd38f1104dD20b3165f130fdAF60Db60C1e