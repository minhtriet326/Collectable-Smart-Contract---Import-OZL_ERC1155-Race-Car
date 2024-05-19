const { ethers } = require("hardhat");
async function main() {
    const TuyetBrown = await ethers.getContractFactory("TuyetLake");
    const tuyetBrown = await TuyetBrown.deploy("Tuyet Lake", "TUY");

    await tuyetBrown.deployed();

    console.log("Successfully deployed smart contract to:", tuyetBrown.address);

    await tuyetBrown.mint("https://ipfs.io/ipfs/QmT8vcSUbpNymwNDERFzDr3bvCs76Pfzhpjg4hncMe84Lc");
    console.log("NFT successfully minted");
}

main().then(() => process.exit(0))
    .catch(err => {
        console.error(err);
        process.exit(1)
    });
//0x9f043b0069c0CDAf793ff00be9fe1eF03c0Ae04c