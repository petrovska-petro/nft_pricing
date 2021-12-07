pragma solidity 0.7.6;

interface IAggregator {
    function latestAnswer() external view returns (uint256);
}
