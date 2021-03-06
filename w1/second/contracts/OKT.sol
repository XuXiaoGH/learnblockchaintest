// contracts/OKT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OKT is ERC20 {
    constructor(uint256 initialSupply) public ERC20("OKT", "OKT") {
        _mint(msg.sender, initialSupply);
    }
}