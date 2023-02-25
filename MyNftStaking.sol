//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyERC20Token is ERC20, Ownable {
    uint256 private initSupply = 10000 * (10**uint256(decimals()));
    address public marketAddress; 

    constructor() ERC20("My ERC20 Token", "MERC20") {
        _mint(msg.sender, initSupply);
    }

    modifier onlyMarket{
        require(msg.sender == marketAddress,"Not allowed to mint, Only Market place can mint");
        _;
    }

    function setAuthority(address _marketAddress)  external onlyOwner{
        marketAddress = _marketAddress;
    }
    function mint(address to, uint256 amount) public onlyMarket {
        _mint(to, amount);
    }
}

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyERC721Token is ERC721, Ownable {
    constructor() ERC721("My ERC721 Token", "MERC721") {}

    function mint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
}

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract MyStakingContract is IERC721Receiver {
    MyERC20Token private token;
    IERC721 private nft;
    
    mapping(uint256 => address) public originalOwner;
    mapping(address => uint256) public stakeCount;
    mapping(address => uint256) public lastStakedTime;

    constructor(address tokenAddress, address nftAddress) {
        token = MyERC20Token(tokenAddress);
        nft = IERC721(nftAddress);
    }

    function onERC721Received(
        address,
        address from,
        uint256 tokenId,
        bytes memory
    ) external override returns (bytes4) {
        require(msg.sender == address(nft), "Only accepts ERC721 tokens from specific contract");
        require(block.timestamp - lastStakedTime[from] >= 24 hours, "Can only stake one NFT per 24 hours");
        stakeCount[from] += 1;
        lastStakedTime[from] = block.timestamp;
        originalOwner[tokenId] = from;
        token.mint(from, 10 * 10**18);
        return this.onERC721Received.selector;
    }

    function withdraw(uint256 tokenId) public {
        require(stakeCount[msg.sender] >0, "You haven't staked any NFT yet");
        require(originalOwner[tokenId] == msg.sender, "Invalid Token Id");
        stakeCount[msg.sender] -= 1 ;
        nft.safeTransferFrom(address(this), msg.sender, tokenId);
    }

}

