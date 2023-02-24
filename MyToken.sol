// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    uint256 private MAX_SUPPLY = 1000 * (10**uint256(decimals())); // 1000 with 18 decimal places

    constructor() ERC20("Naveen Token", "NTK") {
        _mint(msg.sender, MAX_SUPPLY);
    }
}