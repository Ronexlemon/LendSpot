// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.20;
import {ERC20Burnable,ERC20} from '@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol';
//import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title  DecentralizedStableCoin
 * @author Ronex
 * Colateral: (ETH & BTC)
 * Relatively stability: Pegged to USD
 * 
 */



contract DecentralizedStableCoin is ERC20Burnable{
    address owner;
     error DecentralizedStableCoin_MustBeMoreThanZero();
     error DecentralizedStableCoin_BurnAmountExceedsBalance();
     error DecentralizedStableCoin_NotZeroAddress();
     error DecentralizedStableCoin_NotOwner();
   
    constructor()ERC20("Decentralized StableCoin","DC"){
        owner = msg.sender;
    }
    modifier onlyOwner(){
        if(msg.sender != owner){
            revert DecentralizedStableCoin_NotZeroAddress();
        }
        _;
    }

    function burn(uint256 _amount)public override onlyOwner{
        uint256 balance = balanceOf(msg.sender);
        if(_amount <=0){
            revert DecentralizedStableCoin_MustBeMoreThanZero();

        }
        if(balance < _amount){
            revert DecentralizedStableCoin_BurnAmountExceedsBalance();

        }
        super.burn(_amount);
    }

    function mint(address _to,uint256 _amount)external onlyOwner returns(bool){
        if(_to == address(0)){
            revert DecentralizedStableCoin_NotZeroAddress();

        }
        if(_amount <=0){
            revert DecentralizedStableCoin_MustBeMoreThanZero();
        }
        _mint(_to,_amount);
        return true;
    }


}