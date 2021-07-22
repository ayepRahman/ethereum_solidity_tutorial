// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

/**
  The Lottery Smart Contracts
  1. The lottery starts by accepting ETH transactions. Anyone having an Ethereum wallet
     can send a fixeed amount of 0.1 ETH to the contract's address.
  2. The players send ETH directly to the contract address and their Ethereum address is
     registered. A user can send more transsactions hacing more chance to win.
  3. there is a manger, the account that deplys and controls the contract.
  4. At some point, if there are at least 3 players, he can pick a random winner from the players list.
     Only the manager si allowed to see the contract balance and to randomly select the winner.
  5. The contract will transfer the entire balance to the winner;s address and the lottery is reset and 
     ready for the next round. (10% will be deducted and transfer to the contract manager???? =))
 */

 contract Lottery {
   address payable[] public players;
   address public manager;

   constructor() {
     manager = msg.sender;
   }

    // introuduce solidity 0.6 
   receive() external payable {
    // 100000000000000000 wei == 0.1 ETH;
    // require(msg.value == 1 ether, 'You can only stake an exact amount of 0.1 ETH!');
    players.push(payable(msg.sender));
   }

   function getBalance() public view returns(uint) {
    // only manager are allowed to see balance on contract eth balnce.
    require(msg.sender == manager, 'Only manager can view contract balance!');
    return address(this).balance;
   }
   
  function random() public view returns(uint) {
    return  uint( keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
  }
  
  function resetPlayers() public {
    // resetting lottery to an empty array;
    players = new address payable[](0);
  }
  
  function pickWinner() public {
      require(msg.sender == manager, 'Only manager is allowed to pick a winner!');
      require(players.length >= 2);
      
      address payable winner;
      uint amount = getBalance();
      uint deductableValue = amount / 10;
      uint winnerPotValue = (amount / 10) * 9 ;
      uint r = random();
      uint index = r % players.length;
      
      winner = players[index];
      // allowing "manager" address to be payable and transfer the lottery fee of 20% to manager.
      payable(manager).transfer(deductableValue);
      // transfer 90% the lottery pot to the winner.
      winner.transfer(winnerPotValue);
      
      resetPlayers();
  }
 }