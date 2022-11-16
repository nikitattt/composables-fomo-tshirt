import { deploy } from "./ethers-lib";

(async () => {
  try {
    const result = await deploy("FomoNounsTShirt", [
      "0xC143D0F48E0ba1e547Ff0fE489b4DC7A90063683",
    ]);
    console.log(`address: ${result.address}`);
  } catch (e) {
    console.log(e.message);
  }
})();
