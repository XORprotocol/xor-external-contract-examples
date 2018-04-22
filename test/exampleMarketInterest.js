var ExampleMarketInterest = artifacts.require("./ExampleMarketInterest.sol");

contract('ExampleMarketInterest', function(accounts) {

  beforeEach(async function () {
    this.exampleMarketInterest = await ExampleMarketInterest.deployed();
  })

  describe('setMarketInterestContractAddress', function() {
    it('should set Market Interest Contract Address', async function() {
      await this.exampleMarketInterest.setMarketInterestContractAddress("0x0000000000000000000000000000000000000001");
      const marketInterestContractAddress = await this.exampleMarketInterest.getMarketInterestContractAddress();
      assert.equal("0x0000000000000000000000000000000000000001", marketInterestContractAddress);
    })
  })
});
