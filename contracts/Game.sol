// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.7;


// will attack this contract with a attack contract which will use be made possible because this contract calculates random
//number on chain which is a severe vulnerability
  contract Game {
  constructor() payable {}

      function findRandomNumber() private view returns(uint) {
          uint pickedNumber = uint(keccak256(abi.encodePacked(blockhash(block.number), block.timestamp)));
          return pickedNumber;
      }

      function guess(uint _guess) public {
          uint _pickedNumber = findRandomNumber();
          if(_guess == _pickedNumber){
              (bool sent,) = msg.sender.call{value: 0.1 ether}("");
              require(sent, "Failed to send ether");
          }
      }

      function getBalance() view public returns(uint) {
          return address(this).balance;
      }

  }