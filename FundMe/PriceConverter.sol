// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal view returns(uint){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint(price * 10e10);
    }

    function getConversionRate(uint _ethAmount) internal view returns(uint){
       uint ethPrice = getPrice();
       uint ethAmountInUsd = (_ethAmount * ethPrice) / 10e18;
       return ethAmountInUsd;
    }
}