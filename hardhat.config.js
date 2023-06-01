require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */

const QUICKNODE_API_KEY = process.env.QUICK_NODE_API_KEY;
const PRIVATE_ACCOUNT_KEY = process.env.PRIVATE_ACCOUNT_KEY;
const PROD_QUICKNODE_KEY = process.env.PROD_QUICKNODE_KEY;
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;

module.exports = {
  solidity: "0.8.17",
  networks: {
    sepolia: {
      url: QUICKNODE_API_KEY,
      accounts: [PRIVATE_ACCOUNT_KEY],
    },
    // mainnet: {
    //   url: PROD_QUICKNODE_KEY,
    //   accounts: [PRIVATE_ACCOUNT_KEY],
    // },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
};
