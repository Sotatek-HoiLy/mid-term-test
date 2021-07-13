const { ethers } = require("hardhat");
const { expect } = require("chai");

const name = 'HoiLN';
const symbol = 'hoi.ly';



describe("Token Contract", function () {
    let Token;
    let tokenDeployed;
    let owner;
    let addr1;
    let addr2;

    beforeEach(async function () {
        [owner, addr1, addr2] = await ethers.getSigners();
        Token = await ethers.getContractFactory("Token");
        tokenDeployed = await Token.deploy(name, symbol, owner.address, addr1.address, addr2.address, owner.address);
        await tokenDeployed.mint(owner.address, 1000);
    });

    it("Test transfer success", async function () {
        await tokenDeployed.transfer(addr2.address, 100);
        expect(await tokenDeployed.balanceOf(addr2.address)).to.equal(100);
    });

    it("Test transfer when pause", async function () {
        await tokenDeployed.pauseTransfer();
        await expect(tokenDeployed.transfer(addr2.address, 100)).to.be.revertedWith("Admin paused transfer transaction.");
    });

    it("Test transfer when pause and unpause", async function () {
        await tokenDeployed.pauseTransfer();
        await tokenDeployed.unPauseTransfer();
        await tokenDeployed.transfer(addr2.address, 100);
        expect(await tokenDeployed.balanceOf(addr2.address)).to.equal(100);
    });

    it("Test different admin role pause", async function () {
        tokenDeployedRole = await Token.deploy(name, symbol, owner.address, addr1.address, addr2.address, addr2.address);
        await expect(tokenDeployedRole.pauseTransfer()).to.be.revertedWith("Caller is not a admin");
    });

  });