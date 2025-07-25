// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor (uint initialSupply) ERC20("MyToken", "MTK") {
    _mint(msg.sender, initialSupply);
    }
}