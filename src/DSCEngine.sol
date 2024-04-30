// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
/**
 * @title DSC ENGINE
 * @author Ronex
 * @notice  THis contract is the core of DSC System
 */

contract DSCEngine{
    function depositCollateralAndMintDSC()external{}
    /*     
     * @param _tokenCollateralAddress the address of the token to deposit
     * @param _amount  The amount of Collateral to deposit
     */
    function depositCollateral(address _tokenCollateralAddress,
    uint256 _amount)external{


    }

    function redeemCollateralForDSC() external{}

    function burnDSC() external{}
    function redeemCollateral()external{}
    function mintDSC() external{}
    

    function liquidate() external{}
    function getHealthFactor() external view{}



}