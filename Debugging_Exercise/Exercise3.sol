pragma solidity ^0.4.9;

contract Splitter {
    address one;
    address two;

    function Splitter(address _two) {
        if (msg.value > 0) revert();
        one = msg.sender;
        two = _two;
    }

    function () payable {
        uint amount = this.balance / 3;
        require(one.call.value(amount)());
        require(two.call.value(amount)());
    }
}
