var ExampleLoanInterest = artifacts.require("./ExampleLoanInterest.sol");

contract('ExampleLoanInterest', function(accounts) {

  beforeEach(async function () {
    this.exampleLoanInterest = await ExampleLoanInterest.deployed();
  })

  describe('setLoanContractAddress', function() {
    it('should set Loan Contract Address', async function() {
      await this.exampleLoanInterest.setLoanContractAddress("0x0000000000000000000000000000000000000001");
      const loanContractAddress = await this.exampleLoanInterest.getLoanContractAddress();
      assert.equal("0x0000000000000000000000000000000000000001", loanContractAddress);
    })
  })
});
