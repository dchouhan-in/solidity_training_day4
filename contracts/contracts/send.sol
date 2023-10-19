// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Send is Base {
    // contract that will forward
    address payable private toForward;

    // contract that will reject!
    address payable private toReject;

    constructor(address payable _toForward, address payable _toReject) {
        toForward = _toForward;
        toReject = _toReject;
    }

    event EtherSent(uint amount, address indexed to);

    receive() external payable {}

    fallback() external payable {
        (bool sent, ) = toReject.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
        emit EtherSent(msg.value, toReject);
    }

    function sendEther(uint amountToSend) external payable {
        (bool sent, ) = toForward.call{value: amountToSend}("");
        require(sent, "Failed to send Ether");
        emit EtherSent(amountToSend, toForward);
    }
}
