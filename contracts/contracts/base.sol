// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

abstract contract Base {


    function queryBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
