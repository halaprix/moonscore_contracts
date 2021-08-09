const Basic = artifacts.require("Basic");
const PixelFarm = artifacts.require("PixelFarm");
const PIXEL = artifacts.require("PIXEL");
const staked2 = artifacts.require("staked2");

module.exports = function (deployer) {
  //deployer.deploy(Basic, "0xe463274307454c56c96BeA83217DC670508259fB", "0xaa177DfAafF4545dC5aCc2D2a80b6C3a75F45991", false, false, true, "0xe87DE2d5BbB4aF23c665Cf7331eC744B020883bB", 26, "0x8330e0814aa1F0dc1A61e4ed73e6d1315c7Ad732","0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c","0x72FEAC4C0887c12db21CEB161533Fd8467469e6b", "0x72FEAC4C0887c12db21CEB161533Fd8467469e6b","0xC0788A3aD43d79aa53B09c2EaCc313A787d1d607");
  // pcs v2 0x10ed43c718714eb63d5aa57b78b54704e256024e
  // pink 0x319EF69a98c8E8aAB36Aea561Daba0Bf3D0fa3ac
  /*                    address _autoFarmAddress,                    address _feeAddress,  bool _isCAKEStaking,  bool _isSameAssetDeposit,  bool _isAutoComp,  address _farmContractAddress,  uint256 _pid,  address _wantAddress,     address _token0Address,   /bnb                address _token1Address,                       address _earnedAddress,                       address _uniRouterAddress */
  //deployer.deploy(Basic, "0xe463274307454c56c96BeA83217DC670508259fB", "0xaa177DfAafF4545dC5aCc2D2a80b6C3a75F45991", true, false, true, "0xe87DE2d5BbB4aF23c665Cf7331eC744B020883bB", 0, "0x72FEAC4C0887c12db21CEB161533Fd8467469e6b","0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c","0x72FEAC4C0887c12db21CEB161533Fd8467469e6b", "0x72FEAC4C0887c12db21CEB161533Fd8467469e6b","0x319EF69a98c8E8aAB36Aea561Daba0Bf3D0fa3ac");
  //testnet
  deployer.deploy(
    Basic,
    "0xccd9b95dCe09fc70c09ad415A8323fbfFF90c0e7",
    "0xB00b57cc4b922A2C009319c1B714CF2149Af1393",
    false,
    false,
    false,
    "0xccd9b95dCe09fc70c09ad415A8323fbfFF90c0e7",
    0,
    "0xe722D56a6B6716fC79Da130eAC8f18C3816aE0f7",
    "0x094616f0bdfb0b526bd735bf66eca0ad254ca81f",
    "0xe722D56a6B6716fC79Da130eAC8f18C3816aE0f7",
    "0x837E49Fe59eDA1F7952B18384b4c89A441Ec0764",
    "0xD99D1c33F9fC3444f8101754aBC46c52416550D1"
  );
  //deployer.deploy(PixelFarm);
  //deployer.deploy(staked2);
};
