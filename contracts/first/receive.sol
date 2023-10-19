// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Receive is Base {
    address payable _to;

    constructor(address payable to_address) {
        _to = to_address;
    }

    event Received(address from, uint amount);

    receive() external payable {
        emit Received(msg.sender, msg.value);
        _to.transfer(msg.value);
    }
}
