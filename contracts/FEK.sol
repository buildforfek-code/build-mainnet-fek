// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

contract FEK is ERC20Burnable, ERC20Permit, Ownable, Pausable {
    uint8 private immutable _decimalsOverride;
    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 initialSupply,
        address initialReceiver
    ) ERC20(name_, symbol_) ERC20Permit(name_) {
        _decimalsOverride = decimals_;
        if (initialSupply > 0 && initialReceiver != address(0)) {
            _mint(initialReceiver, initialSupply);
        }
    }
    function decimals() public view override returns (uint8) {
        return _decimalsOverride;
    }
    function pause() external onlyOwner {
        _pause();
    }
    function unpause() external onlyOwner {
        _unpause();
    }
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
    function _update(address from, address to, uint256 value) internal override whenNotPaused {
        super._update(from, to, value);
    }
}
