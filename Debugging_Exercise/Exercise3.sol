pragma solidity ^0.4.9;

contract Splitter {
    address one;
    address two;

    function Splitter(address _two){
        one = msg.sender;
        two = _two;
    }

    function () payable {
        uint amount = this.balance / 3;
        one.transfer(amount);
        two.transfer(amount);
    }
}