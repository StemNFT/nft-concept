const { expect } = require("chai");

describe("Test", function() {
    it("Deployment should assign the total supply of tokens to the owner", async function() {
        const [owner] = await ethers.getSigners();

        const Stem = await ethers.getContractFactory("Stem");

        const contract = await Stem.deploy();

        //const ownerBalance = await contract.balanceOf(owner.address);
        contract.createCollection('bitcoin');
        contract.createCollection('eth');
        const collection = await contract.getCollection('bitcoin');
        console.log(collection);
        //expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
    });
});
