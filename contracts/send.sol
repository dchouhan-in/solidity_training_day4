// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Send {
    address payable _to;

    constructor(address to_address) {}

    event SendEther(uint amount, address to, bool status);

    receive() external payable {}

    function queryBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function sendEtherTo(uint amount_to_send) external payable {
        require(address(this).balance >= amount_to_send);
        bool sent = _to.send(amount_to_send);
        emit SendEther(amount_to_send, _to, sent);
    }
}
