const hre = require("hardhat");

async function main() {

  // deploy Simple Token
  const TokenContract = await hre.ethers.getContractFactory("Token");
  const TokenDeploy = await TokenContract.deploy();
  await TokenDeploy.deployed();

  console.log(`Simple Token Address : ${TokenDeploy.address}`);

  // verify token deployed
  try {
    await hre.run("verify:verify", {
      contract: "contracts/Token.sol:Token",
      address: TokenDeploy.address,
      constructorArguments: [],
    });
  } catch (error) {
    console.log(error);
  }
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });