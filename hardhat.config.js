require("@nomiclabs/hardhat-ethers");
/** @type import('hardhat/config').HardhatUserConfig */
require("dotenv").config();
module.exports = {
  networks: {
    bsctest: {
      url: "https://data-seed-prebsc-2-s2.binance.org:8545",//URL đến network đó
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  solidity: {
    version: "0.8.2",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
};
