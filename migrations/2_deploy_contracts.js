var ExampleMarketTrust = artifacts.require("ExampleMarketTrust");
var ExampleMarketInterest = artifacts.require("ExampleMarketInterest");

module.exports = function(deployer) {
  deployer.deploy(ExampleMarketTrust);
  deployer.deploy(ExampleMarketInterest);
};
