pragma solidity ^0.4.24;

contract DigitalOwnership {
    
    /////////////////////////
    //Storage
    /////////////////////////
    
    enum transactionType {
        Publish,
        Transfer
    }

    struct property {
        bytes32 name;
        bytes32 description;
        address author;
        address owner;
        mapping(uint => transaction) transactions;
    }
    
    mapping(uint => property) properties;
    uint propertiesCount;

    struct transaction {
        uint timestamp;
        transactionType tType;
    }
    
    mapping(uint => transaction) transactions;
    uint transactionsCount;

    function addProperty(bytes32 _name, bytes32 _description) public {
        propertiesCount++;

        properties[propertiesCount].name = _name;
        properties[propertiesCount].description = _description;
        properties[propertiesCount].author = msg.sender;
        properties[propertiesCount].owner = msg.sender;

        transactionsCount++;
        
        transactions[transactionsCount].timestamp = now;
        transactions[transactionsCount].tType = transactionType.Publish;
    }

    function viewProperty(uint propertyID) public returns(bytes32 name, bytes32 description, address author, address owner) {
        name =  properties[propertyID].name;
        description = properties[propertyID].description;
        author = properties[propertyID].author;
        owner = properties[propertyID].owner;
        return;
    }

    function transferProperty(uint propertyID, address newOwner) public {
        require(properties[propertyID].owner == msg.sender, "Invalid owner.");

        properties[propertyID].owner = newOwner;

        transactionsCount++;
        
        transactions[transactionsCount].timestamp = now;
        transactions[transactionsCount].tType = transactionType.Transfer;
    }

}