// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {DecentralizedStableCoin} from "./DecentralizedStableCoin.sol";
import {IERC20}from  "@openzeppelin/contracts/token/ERC20/IERC20.sol";
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
    error TransferFailed();


    event CollateralDeposited(address sender,address collateral,uint256 amout);

    //////////////////////////
    //state Variables /////
    ////////////////

mapping(address token => address priceFeed)private s_PriceFeeds ;//token to price feed

mapping(address user => mapping(address token => uint256 amout))private s_CollateralDeposited;


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
    uint256 _amount)external moreThanZero(_amount) isAllowedToken(_tokenCollateralAddress) {
        s_CollateralDeposited[msg.sender][_tokenCollateralAddress] +=_amount;

        emit CollateralDeposited(msg.sender,_tokenCollateralAddress,_amount); 
       bool success = IERC20(_tokenCollateralAddress).transferFrom(msg.sender,address(this),_amount);
       if(!success){
           revert TransferFailed();
       }




    }

    function redeemCollateralForDSC() external{}

    function burnDSC() external{}
    function redeemCollateral()external{}
    function mintDSC() external{}
    

    function liquidate() external{}
    function getHealthFactor() external view{}



}