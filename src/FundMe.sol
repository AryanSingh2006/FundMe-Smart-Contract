// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    using PriceConverter for uint;

    uint public minimumUsd = 5e18;
    address[] public funders;
    address public owner;
    AggregatorV3Interface private s_priceFeed;

    constructor(address priceFeed) {
        owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    mapping(address => uint) public addressToAmountFunded;

    function fund() public payable {
        require(
            (msg.value.getConversionRate(s_priceFeed)) >= minimumUsd,
            "send more than or equal to 1 USD"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    modifier onlyowner() {
        require(msg.sender == owner, "only owner can withdraw");
        _;
    }

    function withdraw() public onlyowner {
        for (uint i; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "call failed");
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
