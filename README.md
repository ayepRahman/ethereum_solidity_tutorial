#State variables

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

#Solidity variables Types

- Solidity is a programming language that is statically-typed, meaning that every variable Types
  must be specified at compile time.

#Simple types:

1. Boolean: true or false
2. Integers
   a. Signed - int8, is between -128 ~ +127 - int256
   b. Unsigned - uint8 - unint256
   - int is alias to int256 & uint is an alias to uinit256
   - int default value of 0;
   - solidity does not support float/double
3. Arrays
   a. Fixed-size Arrays - has a compile-time fixed sizeof - bytes1

#Struct

- A struct is a collection of key:value pairs similar to a mapping, but the values can have many types.
- A struct introduces a new complex data type, that composed elementary data types.
- We introduce structs to represent a singular thing that has properties, Car, Property etc and we can use
  mappings to present a collection of things
- A struct is saved in a storage and if declared in a function it references storage by default.

#Enum

- Enums are used to create user-defined types;
- Enum is explicitly convertible to and from integer;

#Mapping

- It's a date structure that holds key:value pairs. Its similar to Python Dictionaries, JS object or Java HashMaps;
- All keys must have the same type and all values must have the same type;
- The keys can not be of types mapping, dynamic array, enum or struct. The values
  can be any type including mappping;
- Mapping is always saved in storage, it's a state variable. Mappings declared inside functions are also saved in storage;
- The mappings advantage is that lookup time is CONSTANT no matter the size. Arrays have linear search time;
- A mapping is not iterable, we can't iterate through a mapping using a for loop;
- Keys are not saved into the mapping (its hash table data structure). To get a value from the mapping
  we provide a key, the key gets passed through a hashing function, that outputs a predeterminded index
  that returns the correspinding value from the mapping;
- If we want the value of unexisting key we get a default value;

#Storage VS memory

- declaring "memory" variables will not update state variable.
- delcaring "storage" variables will be able to update state variables.

#Build in Global Variables

- msg: contains information about the account that generates the transaction and
  also about the transaction or call
  - msg.sender: account address that generates the transaction.
  - msg.value: eth value (represented in wei) sent to this contract.
  - msg.gas: remaining gas (will be replcaed by gasleft())
  - msg.data: data field from the transaction or call that executed this function
- this: the current contract, explicitly convertible to address (e.g address)
  this.balance returns the contract balance.
- block.timestamp alias for now: returns the Unix epoch
- block.numbers
- block.difficulty
- block.gaslimit
- tx.gasprice: gas price of the transaction.
