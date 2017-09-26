contract PiggyBank {
    address owner;
    uint248 balance;
    bytes32 hashedPassword;

    function piggyBank(bytes32 _hashedPassword) {
        owner = msg.sender;
        balance += uint248(msg.value);
        hashedPassword = _hashedPassword;
    }

    function () payable {
        if (msg.sender != owner) revert();
        balance += uint248(msg.value);
    }

    function kill(bytes32 password) {
        if (keccak256(owner, password) != hashedPassword) revert();
        selfdestruct(owner);
    }
}
