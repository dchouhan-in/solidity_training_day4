// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Forward is Base {
    address payable _to_receive;

    constructor(address payable to_address) {
        _to_receive = to_address;
    }

    event ForwardEther(uint amount, address to, bool status);
    event Received(address from, uint amount);

    receive() external payable {
        emit Received(msg.sender, msg.value);
        _to_receive.transfer(msg.value);
        emit ForwardEther(msg.value, _to_receive, true);
    }
}
