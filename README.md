# nft-marketplace

<b>Week 2 Assignment :<br>
1.MyToken.sol
2.MyNft.sol
3.MyMarket.sol</b>

You must create 3 separate smart contracts: an ERC20 token, and ERC721 token, and a third smart contract that has the authority to receive ERC20 tokens and mint.<br>
You should create an NFT smart contract that will mint if the user pays 10 ERC20 tokens from a separate ERC20 token that you create. (use 18 decimal places as usual).<br>
Hint: the user will need to approve the transfer of ERC20 tokens first.<br>


<b>4.MyNftStaking.sol<br></b>
You must create 3 separate smart contracts: an ERC20 token, and ERC721 token, and a third smart contract that can mint new ERC20 tokens and receive ERC721 tokens.<br>
A classic feature of NFTs is being able to receive them to stake tokens.<br>
Create a contract where users can send their NFTs and withdraw 10 ERC20 tokens every 24 hours. The user can withdraw the NFT at any time. The smart contract must take possession of the NFT and only the user should be able to withdraw it. Beware of the corner case of re-staking to bypass the timer.<br>
IMPORTANT: you must be able to transfer the NFT like in the youtube video I recorded above<br>
Hint: to test the contract, use a shorter timeframe. Remix will respect local timestamps. We will discuss actual testing later.<br>


-Where people commonly mess up:<br>
Not verifying the contract on etherscan<br>
Forgetting decimals in ERC20<br>
Not properly securing the communication among the three contracts<br>
Forcing people to withdraw the NFT to get their tokens<br>
