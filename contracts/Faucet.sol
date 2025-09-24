// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Faucet is Ownable {
    IERC20 public immutable token;
    uint256 public dripAmount;
    uint256 public cooldown;
    mapping(address => uint256) public nextRequestAt;

    constructor(IERC20 token_, uint256 dripAmount_, uint256 cooldown_) {
        token = token_;
        dripAmount = dripAmount_;
        cooldown = cooldown_;
    }

    function setDripAmount(uint256 amount) external onlyOwner {
        dripAmount = amount;
    }

    function setCooldown(uint256 secs) external onlyOwner {
        cooldown = secs;
    }

    function fund(uint256 amount) external onlyOwner {
        token.transferFrom(msg.sender, address(this), amount);
    }

    function claim(address to) external {
        require(block.timestamp >= nextRequestAt[to], "Cooldown");
        nextRequestAt[to] = block.timestamp + cooldown;
        token.transfer(to, dripAmount);
    }
}
