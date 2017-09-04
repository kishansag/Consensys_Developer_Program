pragma solidity ^0.4.4;

contract Splitter {
    address public owner;
    //uint balanceOfContract;
    
    mapping (address => uint256) public balanceOf;
    function Splitter() {
        owner = msg.sender;
    }
    
    function checkBalanceOfTheSplitter() returns (uint){
        return this.balance;
    }
    
    function getBalance(address adr) returns (uint){
        return balanceOf[adr];
    }
    function sendMoney(address adr1, address adr2) payable returns(bool) {
        address sender = msg.sender;
        uint amount = msg.value;
        
        if(amount%2!=0){
            sender.transfer(1);
            balanceOf[sender] += 1;
            amount--;
        }
        adr1.transfer(amount/2);
        adr2.transfer(amount/2);
        
        balanceOf[adr1] += amount/2;
        balanceOf[adr2] += amount/2;
        
        return true;
    }
}
