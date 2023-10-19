// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Base} from "./base.sol";

contract Send is Base {
    // contract that will forward
    address payable _to_forward;

    // contract that will reject!
    address payable _to_reject;

    constructor(address to_address) {}

    event SendEther(uint amount, address to, bool status);

    receive() external payable {}

    fallback() external payable {}

    function sendEtherToRejection(
        uint amount_to_send,
        bool to_reject
    ) external payable {
        require(
            address(this).balance >= amount_to_send,
            "insufficient balance!"
        );

        address payable addr = (to_reject) ? _to_reject : _to_forward;

        bool sent = addr.send(amount_to_send);
        emit SendEther(amount_to_send, _to_reject, sent);
    }
}
