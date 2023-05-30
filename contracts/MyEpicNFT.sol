// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// imports OpenZeppelin Contracts
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// imports helper functions
import {Base64} from "./libraries/Base64.sol";

import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    // Constructor
    constructor() ERC721("SquareNFT", "SQURE") {}

    // State Variables
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string baseSVG =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // Random words to be displayed with nft
    string[] firstWords = [
        "Fantastic",
        "Terrible",
        "Epic",
        "Crazy",
        "Wild",
        "Terrifying",
        "Huge",
        "Tiny",
        "Manic",
        "Funny",
        "Catatonic"
    ];
    string[] secondWords = [
        "Cupcake",
        "Pizza",
        "Milkshake",
        "Curry",
        "Chicken",
        "Sandwich",
        "Potato",
        "Fig",
        "Hamburger",
        "Pickle"
    ];
    string[] thirdWords = [
        "Ford",
        "Grog",
        "Jester",
        "Molly",
        "Caleb",
        "Furn",
        "Vex",
        "Vax",
        "Percy",
        "Scanlen",
        "Kieleth"
    ];

    // Functions
    function pickRandomWords(
        uint256 tokenId
    ) public view returns (string[] memory) {
        uint256 rand1 = psudoRandom(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        uint256 rand2 = psudoRandom(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        uint256 rand3 = psudoRandom(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );

        // Squashes the random number between 0 and the length of the words array it is associated with
        rand1 = rand1 % firstWords.length;
        rand2 = rand2 % secondWords.length;
        rand3 = rand3 % thirdWords.length;

        // Convert to words
        string[] memory words = new string[](3);
        words[0] = firstWords[rand1];
        words[1] = secondWords[rand2];
        words[2] = thirdWords[rand3];

        return words;
    }

    function psudoRandom(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        // Token Id for NFT
        uint256 newTokenId = _tokenIds.current();

        // Grab Random Words
        string[] memory words = pickRandomWords(newTokenId);
        string memory first = words[0];
        string memory second = words[1];
        string memory third = words[2];
        string memory combinedWord = string(
            abi.encodePacked(first, second, third)
        );

        // Concatenate all strings together
        string memory finalSVG = string(
            abi.encodePacked(baseSVG, combinedWord, "</text></svg>")
        );

        // Mints NFT and sends it to the sender of the function
        _safeMint(msg.sender, newTokenId);

        // Creates Json Metadata and base64 encodes it
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        combinedWord,
                        '", '
                        '"description": "A highly acclaimed collection of squares.", '
                        '"image":"data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSVG)),
                        '"'
                        "}"
                    )
                )
            )
        );

        // Create Uri for nft's metadata
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        _setTokenURI(newTokenId, finalTokenUri);

        // Increment the counter for the next NFT's id
        _tokenIds.increment();
    }
}
