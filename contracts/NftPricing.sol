pragma solidity 0.7.6;

import "@openzeppelin/contracts/math/SafeMath.sol";

import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import "@uniswap/v3-core/contracts/libraries/TickMath.sol";
import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import "@uniswap/v3-periphery/contracts/libraries/LiquidityAmounts.sol";

import "interfaces/chainlink/IAggregator.sol";

contract NftPricing {
    using SafeMath for uint256;

    // @dev oracle for BTC / USD
    IAggregator public constant oracleBtcPricing =
        IAggregator(0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c);
    // @dev oracle for BADGER / USD
    IAggregator public constant oracleBadgerPricing =
        IAggregator(0x66a47b7206130e6FF64854EF0E1EDfa237E65339);

    IUniswapV3Pool public constant pool =
        IUniswapV3Pool(0xe15e6583425700993bd08F51bF6e7B73cd5da91B);
    INonfungiblePositionManager public constant positionManager =
        INonfungiblePositionManager(0xC36442b4a4522E871399CD717aBDD847Ab11FE88);

    /// @dev expressed a specific tokenID in USD terms
    function amountsInUsd(uint256 _tokenId) external view returns (uint256) {
        (uint256 amount0, uint256 amount1) = _amountsForLiquidity(_tokenId);
        /// Note: expressed in 8 decimals
        (uint256 btPrice, uint256 badgerPrice) = _getLatestRates();

        uint256 btcAmountInUsd = amount0.mul(btPrice).div(1e16);
        uint256 badgerAmountInUsd = amount1.mul(badgerPrice).div(1e26);

        return btcAmountInUsd.add(badgerAmountInUsd);
    }

    /// @dev latest rates from chainlink oracles for BTC & BADGER
    function _getLatestRates()
        internal
        view
        returns (uint256 btcPrice, uint256 badgerPrice)
    {
        btcPrice = oracleBtcPricing.latestAnswer();
        badgerPrice = oracleBadgerPricing.latestAnswer();
    }

    /// @dev express in token amounts a NFT-tokenID holdings
    function _amountsForLiquidity(uint256 _tokenId)
        internal
        view
        returns (uint256, uint256)
    {
        (
            ,
            ,
            ,
            ,
            ,
            int24 tickLower,
            int24 tickUpper,
            uint128 liquidity,
            ,
            ,
            ,

        ) = positionManager.positions(_tokenId);

        (uint160 sqrtRatioX96, , , , , , ) = pool.slot0();

        return
            LiquidityAmounts.getAmountsForLiquidity(
                sqrtRatioX96,
                TickMath.getSqrtRatioAtTick(tickLower),
                TickMath.getSqrtRatioAtTick(tickUpper),
                liquidity
            );
    }
}
