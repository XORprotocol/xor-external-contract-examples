pragma solidity ^0.4.21;

import 'openzeppelin-solidity/contracts/lifecycle/Destructible.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';
import 'xor-libraries/contracts/XorMath.sol';

/**
 * @title MarketTrustInterface
 * @dev Interface for XOR Market Trust Contract for calculating trust score
 */

contract ExampleMarketTrustInterface {

  // @dev given the address, returns the length of repayments array
  function getRepaymentsLength(address _address) external view returns (uint);

  // @dev given the address, returns the length of defaults array
  function getDefaultsLength(address _address) external view returns (uint);

  // @dev given the address, return the repayment at a specific index
  function getRepayment(address _address, uint _index) external view returns (uint);

  // @dev given the address, return the default at a specific index
  function getDefault(address _address, uint _index) external view returns (uint);
}


/**
 * @title ExampleMarketTrust
 * @dev Example Market Trust contract for showing trust score programmability.
 */

contract ExampleMarketTrust is Destructible {
  using SafeMath for uint;
  using XorMath for uint;

  address creatorAddress;


  ExampleMarketTrustInterface exampleMarketTrustContract;

  /**
   * @dev Set the address of the sibling contract that tracks trust score.
   */
  function setMarketTrustContractAddress(address _address) external onlyOwner {
    exampleMarketTrustContract = ExampleMarketTrustInterface(_address);
  }

  /**
   * @dev Get the address of the sibling contract that tracks trust score.
   */
  function getMarketTrustContractAddress() external view returns(address) {
    return address(exampleMarketTrustContract);
  }

  /**
   * @dev Returns the trust score of a user by using repayments and defaults
   * NOTE: In future, may need to take _marketId as parameter to account for
   *       different identities used in each market
   */
  function getTrustScore(address _address) external view returns (uint) {
    // uint[] repayments = marketTrustContract.getRepayments(_address);
    // uint[] defaults = marketTrustContract.getDefaults(_address);

    uint numRepayments = exampleMarketTrustContract.getRepaymentsLength(_address);
    uint numDefaults = exampleMarketTrustContract.getDefaultsLength(_address);

    // total value of all repayments in Wei
    uint totalRepayments;

    // total value of all defaults in Wei
    uint totalDefaults;

    // numerator of calculation
    uint repaymentComponent;

    // denominator of calculation
    uint defaultComponent;

    uint score;

    for (uint x = 0; x < numRepayments; x++) {
      totalRepayments = totalRepayments.add(exampleMarketTrustContract.getRepayment(_address, x));
    }
    for (uint y = 0; y < numDefaults; y++) {
      totalDefaults = totalDefaults.add(exampleMarketTrustContract.getDefault(_address, y));
    }

    repaymentComponent = totalRepayments.sqrt().div(100000000);

    // @note Calculation below gives defaults 1.25 weight relative to repayments of the same size
    defaultComponent = totalDefaults.sqrt().div(80000000);

    // Base trust score of 20, which is added to repaymentComponent and subtracted by defaultComponent
    score = repaymentComponent.add(20).sub(defaultComponent);
    // TODO: catch throw when score negative

    return score;
  }
}
