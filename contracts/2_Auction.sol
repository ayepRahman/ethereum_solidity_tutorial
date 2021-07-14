// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Auction {
  mapping(address => uint) public bids;

    // "payable" allow eth user to transfer value
    // initializing the mapping variable
    // the key is the address of the account that calles the function
    // and the value the value of wei sent when calling the function
    function bid() payable public {
        // msg.value is a value in "wei".
        bids[msg.sender] = msg.value;
    }
  
}