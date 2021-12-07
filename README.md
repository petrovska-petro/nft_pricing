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