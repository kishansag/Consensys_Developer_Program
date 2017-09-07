pragma solidity ^0.4.15;

contract Remittance{
    address owner;
    struct FundTransferRequest{
        address fundDepositor;
        uint funds;
        uint deadline;
    }
    
    mapping (bytes32 => FundTransferRequest) public hashes;
    
    function Remittance(){
        owner = msg.sender;       
    }
    
    function withdraw(string hashOfPasswordGivenToAlice, string hashOfPasswordGivenToBob) 
        public 
        returns (bool)
    {
            bytes32 resultantHash = keccak256(hashOfPasswordGivenToAlice, hashOfPasswordGivenToBob);
            
            FundTransferRequest storage fundTransferRequest = hashes[resultantHash];
            require(fundTransferRequest.funds>0);

            /*
            I am not sure how I can add a deadline. 
            I have referred to some reviewed projects, but I didn't
            understood the logic behind these code
            e.g.

            if (fundTransferRequest.fundDepositor == msg.sender) {
                require(fundTransferRequest.deadline< block.number);
            } else {
                require(fundTransferRequest.deadlineBlock >= block.number);
            }
            

            */
            uint funds = fundTransferRequest.funds;
            fundTransferRequest.funds = 0;

            msg.sender.transfer(funds);
            return true;
    }

    function deposit(bytes32 hashOfPasswordGivenToAlice, bytes32 hashOfPasswordGivenToBob, uint deadline)
        payable
        public
        returns(bool)
    {
            require(msg.value>0);
            require(hashOfPasswordGivenToAlice != 0);
            require(hashOfPasswordGivenToBob != 0);
            require(deadline > block.number);

            bytes32 resultantHash = keccak256(hashOfPasswordGivenToAlice, hashOfPasswordGivenToBob);
            require(hashes[resultantHash].fundDepositor == 0);
            hashes[resultantHash] = FundTransferRequest({
                fundDepositor:msg.sender,
                funds:msg.value,
                deadline:deadline
                });

            return true;


    }
    
    function kill(){
        if(msg.sender == owner){
            selfdestruct(owner);
        }
    }
}
