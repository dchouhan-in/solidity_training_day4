// License: Unliscensed
pragma solidity ^0.8.20;

contract Sender {
    function receive() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }


    function sendEtherTo()
    

}
