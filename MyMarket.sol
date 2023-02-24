//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./MyNft.sol";


contract MyMarket {
    MyNft public myNft;
    IERC20 public myToken;
    uint256 private constant DECIMAL_FACTOR = 10 ** uint256(18);

    constructor(MyNft _nftAddress, IERC20 _tokenAddress) {
        myNft = _nftAddress;
        myToken = _tokenAddress;
    }

    function mintNftWithToken() external {
        address buyer = msg.sender;
        require(myToken.balanceOf(buyer) > 0, "Not Enough Token Balance in account");
        require(myToken.allowance(buyer,address(this))>=10* DECIMAL_FACTOR, "Atleast 10 ERC20 Tokens needs to be approved for spending");
        myToken.transferFrom(buyer,address(this), 10 * DECIMAL_FACTOR);
        myNft.mint(buyer);
    }

     function getAuthority() external view returns (address){
        return myNft.getAuthority();
    }

}