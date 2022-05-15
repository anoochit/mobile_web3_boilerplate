// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.6.0/token/ERC20/ERC20.sol";

contract GIFT is ERC20 {
    constructor() ERC20("GIFT Token", "GIFT") {
        _mint(msg.sender, 1000000000 * 10**decimals());
    }
}
