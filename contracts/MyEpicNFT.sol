// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// imports OpenZeppelin Contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "hardhat/console.sol";

contract MyEpicNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("SquareNFT", "SQURE") {
        console.log("Hello World!");
    }

    function makeAnEpicNFT() public {
        // Token Id for NFT
        uint256 newTokenId = _tokenIds.current();

        // Mints NFT and sends it to the sender of the function
        _safeMint(msg.sender, newTokenId);

        // Return the NFT's Metadata
        tokenURI(newTokenId);

        // Increment the counter for the next NFT's id
        _tokenIds.increment();
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        require(_exists(_tokenId));
        console.log(
            "A NFT w/ the ID of %s has been minted to %s",
            _tokenId,
            msg.sender
        );
        return "https://jsonkeeper.com/b/HNEU";
    }
}
