## TCL NFT pricing

This repository contains the smart contract for the first draft on how to express the NFTs into USD denomination.

## Usage

Prior to compile the contract will need the following depencies, run:

```
brownie pm clone Uniswap/uniswap-v3-periphery@1.0.0
brownie pm clone Uniswap/uniswap-v3-core@1.0.0
brownie pm clone OpenZeppelin/openzeppelin-contracts@3.4.0
```

## Testing

```
brownie test tests/test_amounts.py -s
```

Output at 4:28pm UTC, 7th Dec: 

```
usd_value_bottom=4,909,998
usd_value_upper=4,463,783
usd_total=9,373,781
```

While Uniswap TVL in the UI expressed $9.36m.

## Calc docs reference (Overview)

The method used to convert the TCL NFTs into **USD** denomination is based on the usage of the following variables: square of the current pool price, square of TCL range ticks and liquidity held within. Under uniswap v3, the liquidity variable, can be thought as the square root of `x * y`, where x and y is the respective amounts of virtual token0 and virtual token1. Keep in mind that the liquidity does not include the fees accumulated, since last contract touch. So, if need be, they may be included with additional computation.

Once, the breakdown amounts of token0 (**wbtc**) and token1 (**badger**) are calculated using uniswapv3 library contract, we can leverage chainlink oracles to convert the amounts of tokens into an **USD** value which could be digested by other contract to have a reference into the value of a specific NFT-tokenID at all times and on-chain.

Documentation reference:

1. https://uniswap.org/whitepaper-v3.pdf
2. https://docs.uniswap.org/protocol/reference/periphery/libraries/LiquidityAmounts#getamountsforliquidity
3. https://github.com/Uniswap/v3-periphery/blob/main/contracts/libraries/LiquidityAmounts.sol#L120
4. https://docs.chain.link/docs/faq/#why-is-latestanswer-reported-at-8-decimals-for-some-contracts-but-for-other-contracts-it-is-reported-with-18-decimals

