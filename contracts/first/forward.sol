// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Forward is Base {
    address payable _to_receive;

    constructor(address to_address) {}

    event SendEther(uint amount, address to, bool status);

    event Received(address from, uint amount);

    receive() external payable {
        emit Received(msg.sender, msg.value);
        _to_receive.transfer(msg.value);
    }
}
