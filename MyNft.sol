//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNft is ERC721, Ownable {
    uint256 public tokenSupply = 0;
    uint256 public constant MAX_SUPPLY = 10;
    address marketAddress;

    constructor() ERC721("Ps4 Controllers", "PSCON") {}

    function setAuthority(address _marketAddress) external onlyOwner {
        require(marketAddress == address(0), "Nfts Already Sold Out to a Market Place");
        marketAddress = _marketAddress;
    }

    function getAuthority() external view returns (address){
        return marketAddress;
    }

    function mint(address _toAddress) external {
        require(marketAddress != address(0),"Market Place address is not set yet");
        require(marketAddress == msg.sender, "Doesnot have authority to mint");
        require(tokenSupply < MAX_SUPPLY, "supply used up");

        _mint(_toAddress, tokenSupply);
        tokenSupply++;
    }

    function renounceOwnership() public pure override {
        require(false, "cannot renounce");
    }

    function transferOwnership(address) public pure override {
        require(false, "cannot transfer ownership");
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmdETQoDfTec8fPC1tBWJPuhQCLBbGtdaifNku8SBrDpYW/";
    }
}
