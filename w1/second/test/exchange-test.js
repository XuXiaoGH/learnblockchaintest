const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Nftexchange", function () {
  it("Should return the new greeting once it's changed", async function () {
    const NftExchange = await ethers.getContractFactory("NftExchange");
    const nftExchange = await NftExchange.deploy();
    await nftExchange.deployed();

    const makeOrderTx = await nftExchange.makeOrder('0xc84F4282998eb3e74b2857Baa1c6a70D7398D641', '1', '0xda184f1D69868a5632A2359905258D1526A9BEEe', '100000');
    // wait until the transaction is mined
    await makeOrderTx.wait();
    expect(await nftExchange.getOrderPrice('0xc84F4282998eb3e74b2857Baa1c6a70D7398D641', '1')).to.equal('100000');
  });
});
