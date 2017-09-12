pragma solidity ^0.4.11;

contract Owned {

    address owner;

    function Owned() {
        owner = msg.sender;
    }

}

contract Remittance is Owned{
    struct FundTransferRequest{
        address fundDepositor;
        uint funds;
        uint deadline;
    }
    uint payments;
    mapping (bytes32 => FundTransferRequest) hashes;
    
    
    function withdraw(string hashOfPasswordGivenToAlice, string hashOfPasswordGivenToBob) 
        public 
        returns (bool)
    {
            bytes32 resultantHash = keccak256(hashOfPasswordGivenToAlice, hashOfPasswordGivenToBob);
            
            FundTransferRequest storage fundTransferRequest = hashes[resultantHash];
            //require(fundTransferRequest.funds>0);
            require(fundTransferRequest.deadline > block.number);
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
            delete fundTransferRequest.funds ;

            msg.sender.transfer(funds);
            return true;
    }

    function deposit(bytes32 resultantHash,  uint duration)
        payable
        returns(bool)
    {
            require(msg.value>0);
            //require(hashOfPasswordGivenToAlice != 0);
            require(resultantHash != 0);
            //uint deadline = block.number + duration;
            //require(deadline > block.number);

            //bytes32 resultantHash = keccak256(hashOfPasswordGivenToAlice, hashOfPasswordGivenToBob);
            require(hashes[resultantHash].fundDepositor == 0);
            uint amount = msg.value - 4712388;
            payments += 4712388;  
            hashes[resultantHash] = FundTransferRequest({
                fundDepositor:msg.sender,
                funds:amount,
                deadline:block.number + duration
                });

            return true;


    }
    
    function kill(){
        if(msg.sender == owner){
            selfdestruct(owner);
        }
    }
}