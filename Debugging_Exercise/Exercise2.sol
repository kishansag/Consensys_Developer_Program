pragma solidity ^0.4.5;

contract WarehouseI {
    // Specified Explicit public visibility
    function setDeliveryAddress(string where) public ;
    function ship(uint id, address customer) public returns (bool handled);
}

contract Store {
    address wallet;
    WarehouseI warehouse;

    // Specified Explicit public visibility
    function Store(address _wallet, address _warehouse) public{
        wallet = _wallet;
        warehouse = WarehouseI(_warehouse);
    }

    // purchase should have been declared 'payable', 
    // considering that it is using msg.value
    function purchase(uint id) payable public returns (bool success) {
        // transfer is better than send. 
        // It would take care of failed payments
        // If the payment is failed transfer would revert the transaction    
        wallet.transfer(msg.value);
        // This would take care in case shipping fails
        // if shipping fails transaction would revert
        if(!warehouse.ship(id, msg.sender)) revert();
        success = true;
    }
}