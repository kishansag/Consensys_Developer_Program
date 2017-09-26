pragma solidity ^0.4.11;

contract PiggyBank {
    address owner;
    uint248 balance;
    bytes32 hashedPassword;

    function piggyBank(bytes32 _hashedPassword) payable public {
        owner = msg.sender;
        balance += uint248(msg.value);
        hashedPassword = _hashedPassword;
    }

    function () payable public {
        if (msg.sender != owner) revert();
        balance += uint248(msg.value);
    }
    
    // Not a good idea to send cleartext passwords
    // Passwords should be hashed offchain
    function kill(bytes32 passwordHash) public {
        if (msg.sender != owner) revert();
        if (passwordHash != hashedPassword) revert();
        
        selfdestruct(owner);
        delete(owner);
    }
}