// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Reject is Base {
    event RejectEvent(address from, uint amount);

    receive() external payable {
        emit RejectEvent(msg.sender, msg.value);
        require(false, "Rejecting txn!");
    }
}
