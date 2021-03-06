pragma solidity ^0.4.21;

import 'openzeppelin-solidity/contracts/lifecycle/Destructible.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

/**
  * @title MarketInterestInterface
  * @dev Interface for XOR Market Interest Contract for calculating interest payment
 */

contract InterestLoanInterface {

 	// @dev given the market id and address of borrower, returns borrower's trust score
 	function getTrustScore(address _address) external view returns (uint);

 }

 /**
  * @title ExampleMarketInterest
  * @dev Example Market Interest contract for showing interest payment programmability.
 */

contract ExampleLoanInterest is Destructible {
  using SafeMath for uint;

  // Risk Coefficient is a coefficient multiplier multiplied with risk rating
  // to calculate interest payment for each borrower in market (in Wei)
  uint riskCoefficient = 3;

  /**
  * @dev Simple custom calculation of risk factor for an individual borrower
  * @param _amt The amount being requested by borrower in current loan request
  */
  function getRisk(address _address, uint _amt, address _loanAddress) private view returns (uint) {
    InterestLoanInterface loanContract = InterestLoanInterface(_loanAddress);
    return _amt.div(loanContract.getTrustScore(_address));       
  }

  /**
  * @dev Simple custom calculation of interest payment for an individual borrower
  * @param _amt The amount being requested by borrower in current loan request
  */
  function getInterest(address _address, uint _amt, address _loanAddress) external view returns (uint) {
    return getRisk(_address, _amt, _loanAddress).mul(riskCoefficient);
  }
}
