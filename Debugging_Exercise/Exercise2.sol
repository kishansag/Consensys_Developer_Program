pragma solidity ^0.4.5;

contract WarehouseI {
    function setDeliveryAddress(string where) public ;
    function ship(uint id, address customer) public returns (bool handled);
}

contract Store {
    address wallet;
    WarehouseI warehouse;

    function Store(address _wallet, address _warehouse) public{
        wallet = _wallet;
        warehouse = WarehouseI(_warehouse);
    }

    function purchase(uint id) payable public returns (bool success) {
        wallet.transfer(msg.value);
        if(!warehouse.ship(id, msg.sender)) revert();
        success = true;
    }
}