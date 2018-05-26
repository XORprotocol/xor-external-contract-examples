var ExampleLoanTrust = artifacts.require("ExampleLoanTrust");
var ExampleLoanInterest = artifacts.require("ExampleLoanInterest");

module.exports = function(deployer) {
  deployer.deploy(ExampleLoanTrust);
  deployer.deploy(ExampleLoanInterest);
};
