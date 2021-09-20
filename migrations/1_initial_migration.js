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
  // DSL-BNB APOYIELD
/*    deployer.deploy(
    Basic,
    "0x021EcE112FD0E64d344583F8463177DFE996E8E5", //address _autoFarmAddress
    "0xFEB2df0A1db88c3d304A0a172a3C176370b9368d", //address _feeAddress
    false, // bool _isCAKEStaking
    false, // bool _isSameAssetDeposit,
    true, // bool _isAutoComp,
    "0xe87de2d5bbb4af23c665cf7331ec744b020883bb", // address _farmContractAddress,
    26, // uint256 _pid,
    "0x8330e0814aa1F0dc1A61e4ed73e6d1315c7Ad732", // address _wantAddress,
    "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c", //  address _token0Address,   /bnb
    "0x72feac4c0887c12db21ceb161533fd8467469e6b", // address _token1Address,
    "0x72feac4c0887c12db21ceb161533fd8467469e6b", // address _earnedAddress,
    "0xc0788a3ad43d79aa53b09c2eacc313a787d1d607" // address _uniRouterAddres
  );  */
  // SOUL-BNB APOYIELD
  deployer.deploy(
    Basic,
    "0x021EcE112FD0E64d344583F8463177DFE996E8E5", //address _autoFarmAddress
    "0xFEB2df0A1db88c3d304A0a172a3C176370b9368d", //address _feeAddress
    false, // bool _isCAKEStaking
    false, // bool _isSameAssetDeposit,
    true, // bool _isAutoComp,
    "0xe87de2d5bbb4af23c665cf7331ec744b020883bb", // address _farmContractAddress,
    11, // uint256 _pid,
    "0x717bcc6f9fcbce8343efb643c6c1fa55faa3e9c6", // address _wantAddress,
    "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c", //  address _token0Address,   /bnb
    "0x67d012f731c23f0313cea1186d0121779c77fcfe", // address _token1Address,
    "0x72feac4c0887c12db21ceb161533fd8467469e6b", // address _earnedAddress,
    "0xc0788a3ad43d79aa53b09c2eacc313a787d1d607" // address _uniRouterAddres
  );  
  //deployer.deploy(PixelFarm);
 // deployer.deploy(PixelFarm);
};
