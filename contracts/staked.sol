// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "./helpers/ERC20.sol";

import "@openzeppelin/contracts/utils/Address.sol";
//import "./libraries/Address.sol";

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
//import "./libraries/SafeERC20.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

//import "./helpers/Ownable.sol";

contract staked2 is ERC20("staked2", "STK2"), Ownable {
    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }
}
