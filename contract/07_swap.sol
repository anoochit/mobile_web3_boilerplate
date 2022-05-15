// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SWAPToken {
    address owner;
    address public GIFT = 0x7ec58138acB343DeBcf7806F25f1583CBC65cda8;

    event SwapToken(address from, uint256 value, uint256 amount);
    event RedeemCoin(address from, uint256 value, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function buyToken() public payable {
        uint256 amount = msg.value;
        uint256 dexBalance = ERC20(GIFT).balanceOf(address(this));
        require(amount > 0, "You need to send some ether");
        require(amount <= dexBalance, "Not enough tokens in the reserve");

        ERC20(GIFT).transfer(msg.sender, amount);
        emit SwapToken(msg.sender, msg.value, amount);
    }

    function sellToken(uint256 amount) public payable {
        require(amount > 0, "You need to sell at least some tokens");
        uint256 allowance = ERC20(GIFT).allowance(msg.sender, address(this));
        require(allowance >= amount, "Check the token allowance");
        ERC20(GIFT).transferFrom(msg.sender, address(this), amount);
        payable(msg.sender).transfer(amount);
    }

    function tokenSupply() public view returns (uint256) {
        return ERC20(GIFT).balanceOf(address(this));
    }

    function coinSupply() public view returns (uint256) {
        return address(this).balance;
    }
}
