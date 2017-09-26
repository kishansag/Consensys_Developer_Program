pragma solidity ^0.4.9;

contract Splitter {
    address one;
    address two;

    function Splitter(address _two) public {
        if (msg.value > 0) revert();
        one = msg.sender;
        two = _two;
    }

    function () payable public{
        // we are supposed to split every value sent and not the balance
        uint amount = msg.value/ 3;
        // whenever we are sending ether, we are passing control
        // Using transfer instead of call.value is much safer
        // For example, 
        // In the previous scenario malicious user could have written
        // a fallback function in such a way that wouldn't behave the 
        // way we would like it to.
        // For example, the malicious user could write a fallback function
        // in such a way that it would recall our fallback function again.
        // That would result in a loop and the malicious user could snatch 
        // our ether considering that we were diving from balance earlier and not
        // msg.value 
        one.transfer(amount);
        two.transfer(amount);
    }
}