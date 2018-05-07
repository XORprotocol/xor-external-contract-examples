pragma solidity ^0.4.21;

import 'openzeppelin-solidity/contracts/lifecycle/Destructible.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

/**
  * @title MarketInterestInterface
  * @dev Interface for XOR Market Interest Contract for calculating interest payment
 */

contract ExampleMarketInterestInterface {

 	// @dev given the market id and address of borrower, returns borrower's trust score
 	function getTrustScore(address _address) external view returns (uint);

 }

 /**
  * @title ExampleMarketInterest
  * @dev Example Market Interest contract for showing interest payment programmability.
 */

contract ExampleMarketInterest is Destructible {
  using SafeMath for uint;

  address creatorAddress;

  ExampleMarketInterestInterface exampleMarketInterestContract;

  // Risk Coefficient is a coefficient multiplier multiplied with risk rating
  // to calculate interest payment for each borrower in market (in Wei)
  uint riskCoefficient = 3;

  /**
    * @dev Set the address of the sibling contract that track interest calculation.
   */
  function setMarketInterestContractAddress(address _address) external onlyOwner {
    exampleMarketInterestContract = ExampleMarketInterestInterface(_address);
  }

  /**
    * @dev Get the address of the sibling contract that track interest calculation.
   */
  function getMarketInterestContractAddress() external view returns(address) {
    return address(exampleMarketInterestContract);
  }

  /**
  * @dev Simple custom calculation of risk factor for an individual borrower
  * @param _amt The amount being requested by borrower in current loan request
  */
  function getRisk(address _address, uint _amt) private view returns (uint) {
    return _amt.div(exampleMarketInterestContract.getTrustScore(_address));       
  }

  /**
  * @dev Simple custom calculation of interest payment for an individual borrower
  * @param _amt The amount being requested by borrower in current loan request
  */
  function getInterest(address _address, uint _amt) external view returns (uint) {
    return getRisk(_address, _amt).mul(riskCoefficient);
  }
}
