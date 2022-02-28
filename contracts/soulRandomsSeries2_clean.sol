// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2;

import "./interfaces/IPancakePair.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableMap.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract soulRandomsSeries2_clean is
    ERC721,
    VRFConsumerBase,
    ERC721Burnable,
    ERC721Enumerable
{
    using SafeMath for uint256;
    using SafeMath for uint8;
    using Address for address;
    using EnumerableSet for EnumerableSet.UintSet;
    using EnumerableMap for EnumerableMap.UintToAddressMap;
    using Strings for uint256;

    // init token Id
    uint16 tokenId = 0;

    // base URI internal
    string public baseURI;

    // chainlink constants
    bytes32 internal keyHash;
    uint256 internal fee;
    // randomness ^ chainlink mappings
    mapping(bytes32 => address) public requestIdToAddress;
    mapping(uint16 => uint256) public tokenIdToRandomNumber;
    mapping(bytes32 => uint16) public requestIdToTokenId;

    address public curve;
    address public lottery;
    address public creator;
    mapping(address => bool) public burners;
    bool setCurveAddress = false;
    bool setLotteryAddress = false;

    uint256 public totalEverMinted = 0;

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
     */
    constructor()
        public
        VRFConsumerBase(
            0x747973a5A2a4Ae1D3a8fDF5479f1514F65Db9C31, // VRF Coordinator
            0x404460C6A5EdE2D891e8297795264fDe62ADBB75 // LINK Token
        )
        ERC721("boost", "bst")
    {
        creator = msg.sender;
        _setBaseURI("https://metadata.apoyield.com/nftv2/");
        keyHash = 0xc251acd21ec4fb7f31bb8868288bfdbaeb4fbfec2df3735ddbd4f7dc8d60103c;
        fee = 0.2 * 10**18; // 0.1 LINK (Varies by network)
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Enumerable) {
        ERC721Enumerable._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     * Requests randomness
     */
    function getRandomNumber(address to) internal {
        require(
            LINK.balanceOf(address(this)) >= fee,
            "Not enough LINK - fill contract with faucet"
        );
        bytes32 requestId = requestRandomness(keyHash, fee);
        tokenId++;
        requestIdToTokenId[requestId] = tokenId;
        requestIdToAddress[requestId] = to;
    }

    /**
     * Callback function used by VRF Coordinator
     */
    function fulfillRandomness(bytes32 requestId, uint256 randomness)
        internal
        override
    {
        tokenIdToRandomNumber[requestIdToTokenId[requestId]] = randomness;
        _mint(requestIdToAddress[requestId], requestIdToTokenId[requestId]);
    }

    function setCurve(address _curve) public {
        require(msg.sender == creator, "only owner");
        curve = _curve;
        setCurveAddress = true;
    }

    function setLottery(address _lottery) public {
        require(msg.sender == creator, "only owner");
        lottery = _lottery;
        setLotteryAddress = true;
    }

    function addPool(address _burner) public {
        require(msg.sender == creator, "!governance");
        burners[_burner] = true;
    }

    function removePool(address _burner) public {
        require(msg.sender == creator, "!governance");
        burners[_burner] = false;
    }

    function setCreator(address _creator) public {
        require(msg.sender == creator, "!governance");
        creator = _creator;
    }

    function toUint8(bytes memory _bytes, uint256 _start)
        internal
        pure
        returns (uint8)
    {
        require(_start + 1 >= _start, "toUint8_overflow");
        require(_bytes.length >= _start + 1, "toUint8_outOfBounds");
        uint8 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x1), _start))
        }

        return tempUint;
    }

    function mint(address to) public virtual returns (uint256 newTokenId) {
        require(msg.sender == curve, "soulRandoms: Minter is not the curve");

        getRandomNumber(to);
        totalEverMinted += 1;

        return tokenId;
    }

    function _baseURI()
        internal
        view
        virtual
        override(ERC721)
        returns (string memory)
    {
        return baseURI;
    }

    function _setBaseURI(string memory baseURI_) internal virtual {
        baseURI = baseURI_;
    }

    function generateRARITYofTokenById(uint256 _tokenId)
        public
        view
        virtual
        returns (uint256)
    {
        _tokenId = uint256(tokenIdToRandomNumber[uint16(_tokenId)]);
        return generateRARITYFromHash(bytes32(_tokenId));
    }

    function generateRARITYFromHash(bytes32 _hash)
        public
        view
        virtual
        returns (uint256)
    {
        bytes memory bhash = abi.encodePacked(_hash);

        /*
 			explain the rarity in here, or not
        */
/*         uint256 RARITY = (1 + toUint8(bhash, 4).div(64)) *
            (1 + toUint8(bhash, 2).div(64)) *
            (1 + toUint8(bhash, 0).div(64)); */

       if (toUint8(bhash,9)>=0 && toUint8(bhash,9)<=237)  {
            uint256 RARITY = (toUint8(bhash,9) * 100 )/253;
		    return RARITY;
        } else if (toUint8(bhash,9)>237 ) {
            uint256 RARITY = (toUint8(bhash,9) * 120 )/253;
		return RARITY;
        } 

       
    }
}

contract Minter is ReentrancyGuard {
    using SafeMath for uint256;

    address payable public creator;
    soulRandomsSeries2_clean public soulRandoms;

    mapping(uint256 => uint8) private _whatMinted;

    event Minted(uint256 indexed tokenId, uint256 indexed pricePaid);

    constructor(address _soulRandoms) {
        creator = payable(msg.sender);
        soulRandoms = soulRandomsSeries2_clean(_soulRandoms); // todo: check naming availability
    }

    function currentPrice() public view virtual returns (uint256 _mintPrice) {
        uint16 supply = uint16(soulRandoms.totalSupply());
        uint256 mintPrice = 0.05 * 1e18;
        if (supply <= 500) {
            mintPrice = 0.05 * 1e18;
        } else if (supply <= 1000) {
            mintPrice = 0.1 * 1e18;
        } else if (supply <= 1250) {
            mintPrice = 0.2 * 1e18;
        } else if (supply <= 1500) {
            mintPrice = 0.4 * 1e18;
        } else {
            mintPrice = 1e18;
        }
        return mintPrice;
    }

    function mintBnb()
        external
        payable
        virtual
        nonReentrant
        returns (uint256 _tokenId)
    {
        uint256 currentMintPrice = currentPrice();
        require(msg.value >= currentMintPrice, "C: Not enough BNB sent");
        require(IERC20(0x72FEAC4C0887c12db21CEB161533Fd8467469e6b).balanceOf(msg.sender) > 20000e18 || IERC20(0x67d012F731c23F0313CEA1186d0121779c77fcFE).balanceOf(msg.sender) > 2000000e8, "C: Not enough DSL or SOUL");
        uint256 tokenId = soulRandoms.mint(msg.sender);
        creator.transfer(currentMintPrice);
        if (msg.value.sub(currentMintPrice) > 0) {
            payable(msg.sender).transfer(msg.value.sub(currentMintPrice));
        }
        emit Minted(tokenId, currentMintPrice);
        return tokenId;
    }
}
