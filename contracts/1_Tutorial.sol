// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

struct Instructor {
    uint age;
    string name;
    address addr;
}

contract Academy {
    Instructor public academyInstructor;
    
    // declaring a new enum type
    enum State {Open, Closed, Unknown}
    
    // declaring and initializing a new state variable of type State
    State public academyState = State.Open;
    
    constructor(uint _age, string memory _name) {
        academyInstructor.age = _age;
        academyInstructor.name = _name;
        academyInstructor.addr = msg.sender;
    }
    
    function changeInstructor(uint _age, string memory _name, address _address) public {
        Instructor memory updatedInstructor = Instructor({
            age: _age,
            name: _name,
            addr: _address
        });
        
        academyInstructor = updatedInstructor;
    }
}

contract School {
        
    
}

contract DynamicArrays{
    // dynamic array of type uint
    uint[] public numbers;
    
    // returning length
    function getLength() public view returns(uint){
        return numbers.length;
    }
    
    // appending a new element
    function addElement(uint item) public{
      numbers.push(item);
    }
    
    // returning an element at an index
    function getElement(uint i) public view returns(uint){
        if(i < numbers.length){
            return numbers[i];
        }
        return 0;
    }
    
    
    // removing the last element of the array
    function popElement() public{
        numbers.pop();
    }
    
    function f() public{
        // declaring a memory dynamic array
        // it's not possible to resize memory arrays (push() and pop() are not available).
        uint[] memory y = new uint[](3);
        y[0] = 10;
        y[1] = 20;
        y[2] = 30;
        numbers = y;
    }
 
}

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