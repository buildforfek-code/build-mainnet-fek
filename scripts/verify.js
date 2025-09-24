const { run } = require("hardhat");

async function main() {
  const addr = process.env.VERIFY_ADDRESS;
  const name = process.env.FEK_NAME || "FEK";
  const symbol = process.env.FEK_SYMBOL || "FEK";
  const decimals = parseInt(process.env.FEK_DECIMALS || "18");
  const initialSupply = process.env.FEK_INITIAL_SUPPLY || "1000000000";
  const receiver = process.env.FEK_RECEIVER;
  if (!addr || !receiver) {
    throw new Error("VERIFY_ADDRESS and FEK_RECEIVER are required");
  }
  await run("verify:verify", {
    address: addr,
    constructorArguments: [
      name,
      symbol,
      decimals,
      require("ethers").utils.parseUnits(initialSupply, decimals),
      receiver
    ]
  });
  console.log("Verification submitted");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
