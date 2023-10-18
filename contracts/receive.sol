// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Receive {
    address payable _to;

    constructor(address to_address) {}

    event Received(address from, uint amount);

    receive() external payable {
        emit Received(msg.sender, msg.value);
        _to.transfer(msg.value);
    }

    function queryBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
