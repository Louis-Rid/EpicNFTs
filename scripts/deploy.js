const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log(`Contract deployed to: ${nftContract.address}`);

  // Call makeAnEpicNFT() function to mint a NFT
  let txn = await nftContract.makeAnEpicNFT();
  await txn.wait();

  // Mint another NFT
  txn = await nftContract.makeAnEpicNFT();
  await txn.wait();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (e) {
    console.log(e);
    process.exit(1);
  }
};

runMain();
