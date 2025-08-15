# FundMe Smart Contract

FundMe is a Solidity smart contract that accepts ETH contributions only if they meet a minimum USD value requirement.  
It uses **Chainlink’s Decentralized Oracle Network** to fetch real-time ETH/USD prices on-chain, ensuring the threshold is always based on up-to-date market data.

## Features
- **Real-time price conversion**: Fetches ETH/USD rates using Chainlink AggregatorV3Interface.
- **Minimum USD enforcement**: Ensures contributions meet a set fiat-equivalent value.
- **Decentralized & Trustless**: No reliance on centralized APIs for price data.
- **Customizable threshold**: Minimum USD value can be adjusted.

## How It Works
1. A user calls the `fund()` function and sends ETH (`msg.value`).
2. The contract retrieves the latest ETH/USD rate via Chainlink price feed.
3. It converts the ETH amount to USD equivalent.
4. If the USD value is below the minimum, the transaction is reverted.

## Use Cases
- Crowdfunding platforms with minimum contribution requirements.
- dApps that enforce payment thresholds in USD.
- Any ETH payment system needing consistent fiat value enforcement.

## Contract Functions
- `fund()`: Accepts ETH if USD value meets the minimum threshold.
- `getPrice()`: Fetches the latest ETH/USD price from Chainlink.
- `getConversionRate(uint _ethAmount)`: Converts ETH amount to USD equivalent.

## Prerequisites
- Hardhat or Remix IDE
- Sepolia ETH (for testnet deployment)
- Chainlink ETH/USD Price Feed address

## Deployment
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/fundme.git
   Deploy the Fund.sol on the testnet
