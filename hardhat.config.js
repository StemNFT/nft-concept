require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.7.3",
  networks: {
      hardhat: {
          chainId: 1337
      },
      ropsten: {
          url: 'https://eth-ropsten.alchemyapi.io/v2/N2g_5DNaBcoRajIltBCUcp40pPaZ0BBj',
          accounts: ['0x086e8646be46e419fc9a56a711b5aa2fdf877a9af4d2ddd1c991cc3dca043240']
      },
      bsctestnet: {
          url: "https://data-seed-prebsc-1-s1.binance.org:8545",
          chainId: 97,
          accounts: {mnemonic: "estival sense three six doll expose slogan fish jump romance require flag"}
      },
      bscmainnet: {
          url: "https://bsc-dataseed.binance.org/",
          chainId: 56,
          accounts: {mnemonic: "festival sense three six doll expose slogan fish jump romance require flag"}
      }
  }
};

