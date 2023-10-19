// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Forward is Base {
    address payable private toReceive;

    constructor(address payable _toReceive) {
        toReceive = _toReceive;
    }

    event ForwardEther(uint amount, address to, bool status);
    event Received(address from, uint amount);

    receive() external payable {
        emit Received(msg.sender, msg.value);
        toReceive.transfer(msg.value);
        emit ForwardEther(msg.value, toReceive, true);
    }
}
