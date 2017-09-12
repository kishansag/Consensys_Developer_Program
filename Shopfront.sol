pragma solidity ^0.4.11;

contract Adminstrated {

    address admin;

    function Adminstrated() {
        admin = msg.sender;
    }

}

contract Shopfront is Adminstrated{

    struct Product { 
        bytes32 productName;
        uint price;
        address owner;
    }

    mapping (address => uint) public balances; 
    mapping (bytes32 => Product) public products;
    
    event logProduct(bytes32 nameHash, bytes32 name, uint price, address owner);
    event logBuy(address sender, bytes32 productId);
    event logWithdrawMoney(address sender);
    event logRemovedProduct(bytes32 productId);
    uint counter = 0;
    
    function addProduct(bytes32 name, uint price) public returns(bool){
        products[keccak256(name)] = Product({
                productName:name,
                price:price,
                owner:msg.sender
            });
        logProduct(keccak256(name), name, price, msg.sender);    
        return true;
    }
    
    function buy(bytes32 productId) public payable returns(bool){
        if(msg.value>=products[productId].price){
            products[productId].owner = msg.sender;
            balances[msg.sender] = balances[msg.sender] + msg.value - products[productId].price;
            
        }
        else {
            balances[msg.sender] = balances[msg.sender] + msg.value;
        }
        
        logBuy(msg.sender, productId);       
        return true;
    }

    function withdrawMoney() public returns(bool){
        if(balances[msg.sender]>0){
            msg.sender.transfer(balances[msg.sender]);
            balances[msg.sender] = 0;
        }
        
        logWithdrawMoney(msg.sender);
        return true;
    }
    
    function removeProduct(bytes32 productId) returns(bool){
        if(msg.sender==products[productId].owner){
            delete products[productId];
            logRemovedProduct(productId);
            return true;
        }
        
        
    }

    function kill(){
        if(msg.sender == admin){
            selfdestruct(admin);
        }
    }
}
