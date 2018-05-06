var ExampleMarketTrust = artifacts.require("./ExampleMarketTrust.sol");

contract('ExampleMarketTrust', function(accounts) {

  beforeEach(async function () {
    this.exampleMarketTrust = await ExampleMarketTrust.deployed();
  })

  describe('setMarketTrustContractAddress', function() {
    it('should set Market Trust Contract Address', async function() {
      await this.exampleMarketTrust.setMarketTrustContractAddress("0x0000000000000000000000000000000000000001");
      const marketTrustContractAddress = await this.exampleMarketTrust.getMarketTrustContractAddress();
      assert.equal("0x0000000000000000000000000000000000000001", marketTrustContractAddress);
    })
  })
});
