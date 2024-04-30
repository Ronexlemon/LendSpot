// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {DecentralizedStableCoin} from "./DecentralizedStableCoin.sol";
/**
 * @title DSC ENGINE
 * @author Ronex
 * @notice  THis contract is the core of DSC System
 * collateral Chainlink token
 * 
 */



contract DSCEngine{
     //////////////////////////
    //Errors /////
    ////////////////

    error NeedMoreThanZero();
    error LengthNotMatch();
    error TokenNotAllowed();

    //////////////////////////
    //state Variables /////
    ////////////////

mapping(address token => address priceFeed)private s_PriceFeeds ;//token to price feed


DecentralizedStableCoin private immutable IDSCStableCoin;




//////////////////////////
    //constructor /////
    ////////////////
    constructor(address[] memory tokenAddresses,
    address[] memory priceFeedAddress,address dscAddress){
        if(tokenAddresses.length != priceFeedAddress.length){
            revert LengthNotMatch();
        }
        for (uint256 i=0;i<tokenAddresses.length;i++){
            s_PriceFeeds[tokenAddresses[i]] = priceFeedAddress[i];
        }
        IDSCStableCoin = DecentralizedStableCoin(dscAddress);

    }




    //////////////////////////
    //Modifiers /////
    ////////////////

    modifier moreThanZero(uint256 _amount){
        if(_amount <=0){
            revert NeedMoreThanZero();
        }
        _;
    }


     modifier isAllowedToken(address _tokenAddress){
        if(s_PriceFeeds[_tokenAddress] == address(0)){
            revert TokenNotAllowed();
        }
       
        _;
    }





    function depositCollateralAndMintDSC()external{}
    /*     
     * @param _tokenCollateralAddress the address of the token to deposit
     * @param _amount  The amount of Collateral to deposit
     */
    function depositCollateral(address _tokenCollateralAddress,
    uint256 _amount)external moreThanZero(_amount){



    }

    function redeemCollateralForDSC() external{}

    function burnDSC() external{}
    function redeemCollateral()external{}
    function mintDSC() external{}
    

    function liquidate() external{}
    function getHealthFactor() external view{}



}