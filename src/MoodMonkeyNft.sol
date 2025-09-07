// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodMonkeyNft is ERC721 {
    error MoodMonkeyNft__CantFlipMoodIfNotOwner();

    enum Mood {
        HAPPY,
        SAD
    }

    uint256 private s_tokenCounter;
    string private s_happyMonkeySvgImageUri;
    string private s_sadMonkeySvgImageUri;

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory happyMonkeySvgImageUri,
        string memory sadMonkeySvgImageUri
    ) ERC721("MoodMonkey", "MOODM") {
        s_tokenCounter = 0;
        s_happyMonkeySvgImageUri = happyMonkeySvgImageUri;
        s_sadMonkeySvgImageUri = sadMonkeySvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.SAD;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (!_isApprovedOrOwner(msg.sender, tokenId)) {
            revert MoodMonkeyNft__CantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happyMonkeySvgImageUri;
        } else {
            imageURI = s_sadMonkeySvgImageUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '",',
                                '"description": "A moody monkey.",',
                                '"image": "',
                                imageURI,
                                '",',
                                '"attributes": [',
                                '{"trait_type": "moodiness", "value": 100}',
                                "]",
                                "}"
                            )
                        )
                    )
                )
            );
    }
}
