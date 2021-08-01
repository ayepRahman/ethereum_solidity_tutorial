# Solidity Tutorial

## State variables

1. Storage

- Holds state varibles;
- Persistent and expensive (cost gas);

2. Stack

- Holds local variables defined inside function if they are not reference types (e.g. int, uint);
- Free to be used (does not cost gas)

3. Memory

- Hold local variables defined inside function if they are refrence types
  but declared with the memory keywordl
- Holod function arguments;
- Like a computer RAM:
- Free to be used (it doesnt cose gas);

Ref Types: string, array, struct & mapping

- constant & immutable cost less gas.

## Solidity variables Types

- Solidity is a programming language that is statically-typed, meaning that every variable Types
  must be specified at compile time.

## Simple types:

1. Boolean: true or false
2. Integers
   a. Signed - int8, is between -128 ~ +127 - int256
   b. Unsigned - uint8 - unint256
   - int is alias to int256 & uint is an alias to uinit256
   - int default value of 0;
   - solidity does not support float/double
3. Arrays
   a. Fixed-size Arrays - has a compile-time fixed sizeof - bytes1

## Struct

- A struct is a collection of key:value pairs similar to a mapping, but the values can have many types.
- A struct introduces a new complex data type, that composed elementary data types.
- We introduce structs to represent a singular thing that has properties, Car, Property etc and we can use
  mappings to present a collection of things
- A struct is saved in a storage and if declared in a function it references storage by default.

## Enum

- Enums are used to create user-defined types;
- Enum is explicitly convertible to and from integer;

## Mapping

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

## Storage VS memory

- declaring "memory" variables will not update state variable.
- delcaring "storage" variables will be able to update state variables.

## Build in Global Variables

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

## Contract Address

- Any contract has its own unique address that is generated at deployment.
- The contract address is generated based on the address of the creator of the contract and the no. of transactions of that acccount (nonce). It can't be calculated in advance.
- There are 2 types of addresses: plain and payable.
- Address is a variable type and has the following members:
  - balance
  - transfer(): should be used in most cases as it's the safest way to send ETH.
  - send(): is like a low-level transfer(). If execustion fails the contract will not stop and send() will return false.
  - transfer() & send() are available only for payable addresses.
  - call(), callcode(), deletegatecall()

## Payable Functions and Contract Balance

- A smart contract can reveice ETH and can have an ETH balance only if there is a payable function defined.
- A contract receives ETH in multiple ways:
  - Simple by sending ETH to the contract adress by an EOA account.In this case the contract needs at least a function called receive() or a fallback().
  - By calling a payable function and sending ETH with taht transaction.
- The ETH balance of the contract is in possession of anyone who can call the transfer() function of the address.

## Variables & Functions Visibility

There are 4 types of visibilities for function and state variables.

1. Public

- The function is part of the contract interface and can be called both internally (from within the same contract) and externally (from other contracts or by EOA account).
- The is the default for functions.
- A getter is automatically created for public variables. They can be easily accessed from DApps.

2. Private

- Private functions and variables are available only in the contract ehy are defined in (not in other contractsL derived or underived). Private is a subset of Internal.
- They can be accessed in the current contract only by getter function.

3. Internal

- Functions are accessible only from the contract they are defined in and from derived contracts.
- This is the default for state variables. They can be accessed in the current and derived contracts.

4. External

- The function is part of the contract interface, can be accessed only from other contracts or by EOA accounts using transactions. It's automatically public.
- Not-available for state variables.

## Function Modifiers

- Functions modifiers are used to modify the behavior of a function. They test a condition before calling a function which will be executed only if the condition of the modifier evaluates to true.
- Using function modifiers you acoid redundant-code and possible errors.
- They are contract properties and are inherited.
- They dont return and use only require().
- They are defined using the modifier keyword.

## Withdrawal Pattern

- We dont proactively send back the funs to the users that didnt win the auction. We'll use the "withdrawal pattern" instead.
- We should only send ETH to a user when he explicitly requests it.
- This is the "withdrawal" pattern and helps use avoiding "re-entrance attacks" that could cause unexpected behavior, including catastophic financial loss for the users.

## Solidity Events

- Each ethereum transaction has attached to it a receipt which contains zero or more log entries.
- They are called "events" in Solidity and Web3, and logs inEVM and Yellow pages.
- Events allow Javascript callback functions that listen for them in the user interface to update the interface accordingly.
- Generated events are not accessible from within contracts, not even from the one which has created and emitted them. They can only be accessed by external actors such as JS.
- Events are inheritable members of contracts so if you declare an event in an interface or base contract you dont need to declare it in the derived contracts. You just emit it!.
- An Event is declared using the event keyword and by convention its name starts with an uppercase letter.

```
// declaring an Event, naming convention using CamelCase.

event Transfer(address _to, uint _value);
```

- Event are emmited insider setter functions using emit followed by the name of the event.

```
// emit an Event
emit Transfer(_to, msg.value)
```

## Inheritance in Solidity

- A contract acts like a class. A contract can inherit from another contract known as the base contract to share a common interface.
- The general inheritance system is very similar to Python's, especially concerning multiple inheritance.
- Solidity supports multiple inheritance including polymorphism. Multiple inheritace introduces problems like the "diamond problem" and should be avoided.
- When a contract inherites from multiple contracts, only a single contract is created on the blockchain, and the code from all the base contracts is copied into the created contract.
- All function calls are virtual, which means that the most derived function is called, except when the contract name is explicitly given.
- When deploying a derived contract the case contract's constructor is automatically called.
- "is" keyword uis used whe declaring a new derived contract.

## Abstract Contracts

- An abstract contract is the one with at least one function that is not implemented and is declared using the abstract keywork.
- You can mark a contract as being abstract even though all functions are implemented.
- An abstract contract cannot be deployed.

## Interfaces

- Interfaces are similar to abstract contracts, but they cannot have any functions implemented.
- Interfaces can be inherited.
- Interfaces have further restractions.
  - They cannot inherit from other contracts,but they can inherit from other interfaces.
  - All declared functions must be external
  - They cannot declare a constructor.
  - They cannot declare state variables.
- An interface is created using the interface keyword instead of contract.

## ERC20 Token Standard

- "A token" is designed to represent something of value but also thins like voting right or discount vouchers. "It can represent any fungible trading good".
- ERC stands for "Ethereum Request for Comments". An ERC is a form of proposal and its purpose is to define standards and practices.
- EIP stands for Ethereum Improvement Proposal and makes changes to the actual code of Ethereum. ERC is just giudance on how to use different features of Ethereum.
- ERC20 is a proposal that intends to standardize how a token contract should be defined, how we interact with such a token contract and how these contracts interact with each other.
- ERC20 is a standard interface used by application such as wallets, decentralized exchanges, and so on to interact with tokens.
- transfer() function is used to send tokens from one uer to another, but it doesnt work well when tokens are being used to pay for a function in a smart contract.
- ERC20 standard defined a mapping data structure named allowed and 2 functions approve() and transferFrom() that permit a token owner to give another address approval to transfer up to a number of tkens known as allwance. Allowances for an address can only be set by the owner of that address.
