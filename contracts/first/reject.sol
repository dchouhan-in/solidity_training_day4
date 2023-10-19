// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Reject is Base {
    address payable _to;

    constructor(address payable to_address) {
        _to = to_address;
    }

    event RejectEvent(address from, uint amount);

    receive() external payable {
        require(false, "Rejecting txn!");
    }

}
