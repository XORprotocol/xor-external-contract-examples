var Ownable = artifacts.require("zeppelin-solidity/contracts/ownership/Ownable.sol");
var Destructible = artifacts.require("zeppelin-solidity/contracts/lifecycle/Destructible.sol");
var SafeMath = artifacts.require("zeppelin-solidity/contracts/math/SafeMath.sol");
var XorMath = artifacts.require("xor-libraries/contracts/XorMath.sol");
var ExampleMarketTrust = artifacts.require("./ExampleMarketTrust.sol");
var ExampleMarketInterest = artifacts.require("./ExampleMarketInterest.sol");

module.exports = function(deployer) {
  deployer.deploy(Ownable);
  deployer.link(Ownable, Destructible);
  deployer.deploy(Destructible);
  deployer.link(Destructible, ExampleMarketTrust);
  deployer.link(Destructible, ExampleMarketInterest);
  deployer.deploy(SafeMath);
  deployer.link(SafeMath, ExampleMarketTrust);
  deployer.link(SafeMath, ExampleMarketInterest);
  deployer.link(SafeMath, XorMath);
  deployer.deploy(XorMath);
  deployer.link(XorMath, ExampleMarketTrust);
  deployer.deploy(ExampleMarketTrust);
  deployer.deploy(ExampleMarketInterest);
};
