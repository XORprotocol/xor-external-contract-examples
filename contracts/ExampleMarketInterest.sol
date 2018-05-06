pragma solidity ^0.4.21;

import 'openzeppelin-solidity/contracts/lifecycle/Destructible.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

/**
  * @title MarketInterestInterface
  * @dev Interface for XOR Market Interest Contract for calculating interest payment
 */

 contract MarketInterestInterface {

 	// @dev given the market id and address of borrower, returns borrower's trust score
 	function getTrustScore(uint _marketId, address _address) public view returns (uint);

 	// @dev given the market id, returns riskConstant of market
 	function getRiskConstant(uint _marketId) public view returns (uint);
 }

 /**
  * @title ExampleMarketInterest
  * @dev Example Market Interest contract for showing interest payment programmability.
 */

contract ExampleMarketTrust is Destructible {
  using SafeMath for uint;

  MarketInterestInterface marketInterestContract;

  /**
    * @dev Set the address of the sibling contract that track interest calculation.
   */
  function setMarketInterestContractAddress(address _address) external onlyOwner {
    marketInterestContract = MarketInterestInterface(_address);
  }

  /**
  * @dev Simple custom calculation of risk factor for an individual borrower
  * @param _amt The amount being requested by borrower in current loan request
  */
  function getRisk(uint _marketId, address _address, uint _amt) private view returns (uint) {
    return _amt.div(marketInterestContract.getTrustScore(_marketId, _address));       
  }

  /**
  * @dev Simple custom calculation of interest payment for an individual borrower
  * @param _amt The amount being requested by borrower in current loan request
  */
  function getInterest(uint _marketId, address _address, uint _amt) public view returns (uint) {
    return getRisk(_marketId, _address, _amt).mul(marketInterestContract.getRiskConstant(_marketId));
  }
}