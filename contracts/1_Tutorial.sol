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
    
    @Solidity variables Types
    - Solidity is a programming language that is statically-typed, meaning that every variable Types
      must be specified at compile time.
    
    Simple types:
    1. Boolean: true or false
    2. Integers
        a. Signed
            - int8, is between -128 ~ +127
            - int256
        b. Unsigned 
            - uint8
            - unint256
        - int is alias to int256 & uint is an alias to uinit256
        - int default value of 0;
        - solidity does not support float/double
    3. Arrays
        a. Fixed-size Arrays
            - has a compile-time fixed sizeof
            - bytes1

*/

contract FixedSizeArrays{
    // declaring a fixed-size array of type uint with 3 elements
    uint[3] public numbers = [2, 3, 4];
     
    // declaring fixed-size arrays of type bytes
    bytes1 public b1;
    bytes2 public b2;
    bytes3 public b3;
    //.. up to bytes32
     
    // changing an element of the array at a specific index
    function setElement(uint index, uint value) public{
        numbers[index] = value;
    }
     
    // returning the number of elements in the array
    function getLength() public view returns(uint){
        return numbers.length;
    }
     
    // setting bytes arrays
    function setBytesArray() public{
        b1 = 'a'; // => 0x61 (ASCII code of `a` in hex)
        b2 = 'ab'; // => 0x6162
        b3 = 'z'; // => 0x7A
        // b3[0] = 'a'; // ERROR => can not change individual bytes
         
        // byte is an alias for bytes1 on older code
    }
}

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