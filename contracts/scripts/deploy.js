const { ethers } = require("hardhat");

async function main() {
  const name = process.env.FEK_NAME || "FEK";
  const symbol = process.env.FEK_SYMBOL || "FEK";
  const decimals = parseInt(process.env.FEK_DECIMALS || "18");
  const initialSupply = ethers.utils.parseUnits(process.env.FEK_INITIAL_SUPPLY || "1000000000", decimals);
  const receiver = process.env.FEK_RECEIVER || (await ethers.getSigners())[0].address;

  const FEK = await ethers.getContractFactory("FEK");
  const fek = await FEK.deploy(name, symbol, decimals, initialSupply, receiver);
  await fek.deployed();

  console.log("FEK deployed:", fek.address);
  console.log("Owner:", await fek.owner());
  console.log("Receiver:", receiver);

  if (process.env.DEPLOY_FAUCET === "true") {
    const drip = ethers.utils.parseUnits(process.env.FAUCET_DRIP || "10", decimals);
    const cooldown = parseInt(process.env.FAUCET_COOLDOWN || "3600");
    const Faucet = await ethers.getContractFactory("Faucet");
    const faucet = await Faucet.deploy(fek.address, drip, cooldown);
    await faucet.deployed();
    console.log("Faucet deployed:", faucet.address);
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
