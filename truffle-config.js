require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    // BSC Mainnet
    bsc: {
        provider: () => new HDWalletProvider({
            privateKeys: [process.env.PRIVATE_KEY], // Array of private keys
            providerOrUrl: process.env.BSC_MAINNET_RPC,
          }),
      network_id: 56,       // BSC Mainnet id
      confirmations: 2,     // # of confirmations to wait between deployments
      timeoutBlocks: 200,   // # of blocks before a deployment times out
      skipDryRun: true,     // Skip dry run before migrations
      gasPrice: 5000000000  // 5 gwei
    },
    // BSC Testnet
    bscTestnet: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC,
        process.env.BSC_TESTNET_RPC
      ),
      network_id: 97,       // BSC Testnet id
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
      gasPrice: 10000000000 // 10 gwei
    }
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.19",    // Change this to match your contract's Solidity version
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  },

  // Plugin for verification
  plugins: [
    'truffle-plugin-verify'
  ],

  // API keys for verification
  api_keys: {
    bscscan: process.env.BSCSCAN_API_KEY // Add this to your .env if you want to verify contracts
  }
}; 