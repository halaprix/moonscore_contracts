pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

import "./interfaces/IPancakeswapFarm.sol";

import "./interfaces/IPancakeRouter01.sol";

import "./interfaces/IPancakeRouter02.sol";

contract whaleFucker is Ownable, ReentrancyGuard {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    address public wantAddress = 0x14b4A4E306343c61677980479aCD8326E6F90b50;
    address public farmContractAddress =
        0xcf067c9D591c3bdDf706e1D7dB3B646Ef712DBA1;
    address public earnedAddress = 0xd07efBcDD7242212fF67372cDB2c9DDAa0290fAe;
    address public uniRouterAddress =
        0x10ED43C718714eb63d5aA57B78B54704E256024E;
    address public constant wbnbAddress =
        0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    address[] public earnedToToken1Path = [earnedAddress, wbnbAddress];
    uint256 public pid = 1;
    uint256 public sellAmount = 5 * (10**18);
    uint256 public startBlock = 8799601;

    function setSellAmount(uint256 _sellAmount) public onlyOwner {
        sellAmount = _sellAmount;
    }

    function setStartBlock(uint256 _startBlock) public onlyOwner {
        startBlock = _startBlock;
    }

    function _farm() internal {
        uint256 wantAmt = IERC20(wantAddress).balanceOf(address(this));
        IERC20(wantAddress).safeIncreaseAllowance(farmContractAddress, wantAmt);
        IPancakeswapFarm(farmContractAddress).deposit(pid, wantAmt);
    }

    function withdraw(uint256 _wantAmt) public onlyOwner {
        IPancakeswapFarm(farmContractAddress).withdraw(pid, _wantAmt);
        uint256 withdrawBalance = IERC20(wantAddress).balanceOf(address(this));
        IERC20(wantAddress).safeTransfer(address(msg.sender), withdrawBalance);
    }

    function deposit(uint256 _wantAmt) public {
        IERC20(wantAddress).safeTransferFrom(
            address(msg.sender),
            address(this),
            _wantAmt
        );

        _farm();
    }

    function earn() public {
        // Harvest whale
        if (startBlock > block.number) {
            return;
        } else if (IERC20(earnedAddress).balanceOf(address(this)) == 0) {
            IPancakeswapFarm(farmContractAddress).withdraw(pid, 0);
            uint256 earnedAmt = IERC20(earnedAddress).balanceOf(address(this));
            IERC20(earnedAddress).safeIncreaseAllowance(
                uniRouterAddress,
                earnedAmt
            );
            IPancakeRouter02(uniRouterAddress)
                .swapExactTokensForTokensSupportingFeeOnTransferTokens(
                sellAmount,
                0,
                earnedToToken1Path,
                owner(),
                block.timestamp.add(600)
            );
            IPancakeRouter02(uniRouterAddress)
                .swapExactTokensForTokensSupportingFeeOnTransferTokens(
                sellAmount,
                0,
                earnedToToken1Path,
                owner(),
                block.timestamp.add(600)
            );
        } else {
            IPancakeRouter02(uniRouterAddress)
                .swapExactTokensForTokensSupportingFeeOnTransferTokens(
                sellAmount,
                0,
                earnedToToken1Path,
                owner(),
                block.timestamp.add(600)
            );
            IPancakeRouter02(uniRouterAddress)
                .swapExactTokensForTokensSupportingFeeOnTransferTokens(
                sellAmount,
                0,
                earnedToToken1Path,
                owner(),
                block.timestamp.add(600)
            );
            IPancakeRouter02(uniRouterAddress)
                .swapExactTokensForTokensSupportingFeeOnTransferTokens(
                sellAmount,
                0,
                earnedToToken1Path,
                owner(),
                block.timestamp.add(600)
            );
        }
    }

    function sell(uint256 _amount) public {
        // Harvest whale

        //IPancakeswapFarm(farmContractAddress).withdraw(pid, 0);

        // Converts farm tokens into want tokens

        // Swap whale for bnb
        IPancakeRouter02(uniRouterAddress)
            .swapExactTokensForTokensSupportingFeeOnTransferTokens(
            _amount,
            0,
            earnedToToken1Path,
            owner(),
            block.timestamp.add(600)
        );
    }
}
