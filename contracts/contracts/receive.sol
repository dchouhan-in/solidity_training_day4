// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Receive is Base {
    event EtherReceived(address from, uint amount);

    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }
}
