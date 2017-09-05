pragma solidity ^0.4.4;

contract Splitter {
    address public owner;
    //uint balanceOfContract;
    
    mapping (address => uint256) public balanceOf;
    function Splitter() {
        owner = msg.sender;
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
    
    function withdraw() public returns(bool success){
        success = false;
        require(balanceOf[msg.sender]>0);
        uint value = balanceOf[msg.sender];
        
        balanceOf[msg.sender] = 0;
        msg.sender.transfer(value);
        
        success = true;
    }
}
