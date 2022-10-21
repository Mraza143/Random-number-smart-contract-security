const { ethers, waffle } = require("hardhat");
const { expect } = require("chai");
const { BigNumber, utils } = require("ethers");

describe("Attack", function () {
  it("verifies that the attack contract is able to hack the game contract", async function () {

    const Game = await ethers.getContractFactory("Game");
    //depositing 5 ethers in the contract with deployment
    const _game = await Game.deploy({ value: utils.parseEther("0.1") });
    await _game.deployed();


    // Deploying  the attack contract with the address of the game smart contract
    //which it requires in the constructor
    const Attack = await ethers.getContractFactory("Attack");
    const _attack = await Attack.deploy(_game.address);


    const tx = await _attack.attack();
    await tx.wait();

    const balanceGame = await _game.getBalance();
    // Balance of the Game contract becomes zero even though we had 0.1 ether in it
    expect(balanceGame).to.equal(BigNumber.from("0"));
  });
});