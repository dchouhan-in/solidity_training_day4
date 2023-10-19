// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Send is Base {
    // contract that will forward
    address payable _to_forward;

    // contract that will reject!
    address payable _to_reject;

    constructor(
        address payable to_forward_address,
        address payable to_reject_address
    ) {
        _to_forward = to_forward_address;
        _to_reject = to_reject_address;
    }

    event SendEther(uint amount, address to, bool status);

    receive() external payable {}

    fallback() external payable {
        (bool sent, ) = _to_reject.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
        emit SendEther(msg.value, _to_reject, true);
    }

    function sendEther(uint amount_to_send) external payable {

        // _to_forward.transfer(amount_to_send);
        (bool sent, ) = _to_forward.call{value: amount_to_send}("");
        require(sent, "Failed to send Ether");
        emit SendEther(amount_to_send, _to_forward, true);
    }
}