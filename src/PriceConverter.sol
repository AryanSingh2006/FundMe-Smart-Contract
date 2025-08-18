// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice(AggregatorV3Interface priceFeed) internal view returns (uint) {
       
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint(price * 10e10);
    }

    function getConversionRate(uint _ethAmount, AggregatorV3Interface priceFeed) internal view returns (uint) {
        uint ethPrice = getPrice(priceFeed);
        uint ethAmountInUsd = (_ethAmount * ethPrice) / 10e18;
        return ethAmountInUsd;
    }
}
