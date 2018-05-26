var ExampleLoanTrust = artifacts.require("./ExampleLoanTrust.sol");

contract('ExampleLoanTrust', function(accounts) {

  beforeEach(async function () {
    this.exampleLoanTrust = await ExampleLoanTrust.deployed();
  })

  describe('setLoanContractAddress', function() {
    it('should set Loan Contract Address', async function() {
      await this.exampleLoanTrust.setLoanContractAddress("0x0000000000000000000000000000000000000001");
      const loanContractAddress = await this.exampleLoanTrust.getLoanContractAddress();
      assert.equal("0x0000000000000000000000000000000000000001", loanContractAddress);
    })
  })
});
