// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";


contract Lottery {
  address payable[] public players;
  uint256 public usdEntryFee;
  AggregatorV3Interface internal ethUsdPriceFeed;
  enum LOTTERY_STATE {
    OPEN,
    CLOSED,
    CALCULATING_WINNER
  }
  LOTTERY_STATE public lottery_state;

  constructor(address _priceFeedAddress) public{
    usdEntryFee = 50 * (10**18);
    ethUsdPriceFeed = AggregatorV3Interface(_priceFeedAddress);
    lottery_state = LOTTERY_STATE.CLOSED;
  }

  function enter() public {
    require(msg.value >= getEntranceFee(). "Not enough ETH!");
    players.push(msg.sender);
  }  
  
  function getEntranceFee() public view returns (uint256) {
    (, int256 price, , , ) = ethUsdPriceFeed.latestRoundData();
    uint256 adjustedPrice = uint256(price) * 10**10; 
    uint256 costToEnter = (usdEntryFee * 10**18) / adjustedPrice;
    return costToEnter;
    }

  function startLottery() public {}

  function endLottery() public {}

}