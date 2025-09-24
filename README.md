# FEK Mainnet (BEP-20)

Production-ready BEP-20 token for BNB Chain mainnet using OpenZeppelin. Includes optional Faucet, Hardhat deployment, and Etherscan verification.

## Requirements
- Node.js 18+
- A funded deployer wallet on BNB Chain
- RPC URLs and BscScan API key

## Setup
1. `npm install`
2. Copy `.env.example` to `.env` and fill values

## Build
`npm run build`

## Deploy
Mainnet: `npm run deploy:bsc`  
Testnet: `npm run deploy:testnet`

## Verify
Set `VERIFY_ADDRESS` in `.env`  
Mainnet: `npm run verify:bsc`  
Testnet: `npm run verify:testnet`

## Contract Features
- ERC20 with custom decimals
- Burnable
- Permit (EIP-2612)
- Ownable
- Pausable
- Owner mint
