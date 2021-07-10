// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


/*
    @State variables
    1. Storage
    - Holds state varibles;
    - Persistent and expensive (cost gas);
    
    2. Stack
    - Holds local variables defined inside fucntuions fi they are not reference types (e.g. int);
    - Free to be used (does not cost gas)
    
    3. Memory
    - Hold local variables defined inside function if they are refrence types
      but declared with the memory keywordl
    - Holod function arguments;
    - Like a computer RAM:
    - Free to be used (it doesnt cose gas);
    
    Ref Types: string, array, struct & mapping
    
    - constant & immutable cost less gas.

*/

contract Property {
    int public price;
    string public location;
    // declaring "immutable" will not allow the variables to be updated once deploy
    // can be initialized at declaration or in the constructor only
    address immutable public owner;
    
    /*
        @Constructor
        - we can deploy our contract with args for us to set our storage variables
        - is executed only once at contract's deployment

    */
    constructor(int _price, string memory _location) {
        price = _price;
        location = _location;
        /*
            msg.sender is a global variables, is a public address account
            that interact with the smart contract
        */     
        owner = msg.sender;
    }
    
    // Setter
    // Set the price
    function setPrice(int _price) public {
        price = _price;
    }
    
    function setLocation(string memory _location) public {
        location = _location;
    }
    
    
    // Getter 
    // Get the price
    /* This function is redundant since setting our storage variable with public will generate
        a getter function for our storage variables
    */
    function getPrice() public view returns(int) {
        return price;
    }
    
}