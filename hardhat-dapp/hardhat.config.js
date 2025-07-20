require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: "https://sepolia.infura.io/v3/67d575577f8d4e98a992dada3dffc214",
      accounts: ["508cb593367f47b8aafc1f00a5d328138082ca9fa8fb56925147c07620a372f2"]
    },
    mainnet: {
      url: "https://mainnet.infura.io/v3/67d575577f8d4e98a992dada3dffc214",
      accounts: ["508cb593367f47b8aafc1f00a5d328138082ca9fa8fb56925147c07620a372f2"]
    }
  }
};
