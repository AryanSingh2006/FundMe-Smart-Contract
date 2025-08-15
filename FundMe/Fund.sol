// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{

    using PriceConverter for uint;

    uint public minimumUsd = 5e18;
    address[] public funders;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint) public addressToAmountFunded;

    modifier onlyowner(){
        require(msg.sender == owner, "only owner can withdraw");
        _;
    }

    function fund() public payable {
        require((msg.value.getConversionRate()) >= minimumUsd, "send more than or equal to 1 USD");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }



    function withdraw() public onlyowner {

        for (uint i; i < funders.length; i++) 
        {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }
    
}