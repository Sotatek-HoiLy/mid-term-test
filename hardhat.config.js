require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.0",
  defaultNetwork: "rinkeby",
  networks: {
    rinkeby: {
      url: 'https://rinkeby.infura.io/v3/67f38210ade24db9ad02b3a8016f0125',
      // chainId: 4,
      accounts: ['71ea6c02710fdc9294e9fe40d7707f0b5cec2381732c9f048317c468cdfc42af']
    },
    goerli: {
      url: 'https://goerli.infura.io/v3/67f38210ade24db9ad02b3a8016f0125',
      // chainId: 4,
      accounts: ['71ea6c02710fdc9294e9fe40d7707f0b5cec2381732c9f048317c468cdfc42af']
    },
    testnet_bsc: {
      url: 'https://data-seed-prebsc-1-s1.binance.org:8545/',
      // chainId: 4,
      accounts: ['71ea6c02710fdc9294e9fe40d7707f0b5cec2381732c9f048317c468cdfc42af']
    }
  }
};