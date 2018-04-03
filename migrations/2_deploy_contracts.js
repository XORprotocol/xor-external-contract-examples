var Ownable = artifacts.require("./zeppelin/ownership/Ownable.sol");
var Killable = artifacts.require("./zeppelin/lifecycle/Killable.sol");
var SafeMath = artifacts.require("./libraries/SafeMath.sol");
var XorMath = artifacts.require("./libraries/XorMath.sol");
var ExampleMarketTrust = artifacts.require("./ExampleMarketTrust.sol");

module.exports = function(deployer) {
  deployer.deploy(Ownable);
  deployer.link(Ownable, Killable);
  deployer.deploy(Killable);
  deployer.link(Killable, ExampleMarketTrust);
  deployer.deploy(SafeMath);
  deployer.link(SafeMath, ExampleMarketTrust);
  deployer.link(SafeMath, XorMath);
  deployer.deploy(XorMath);
  deployer.link(XorMath, ExampleMarketTrust);
  deployer.deploy(ExampleMarketTrust);
};
