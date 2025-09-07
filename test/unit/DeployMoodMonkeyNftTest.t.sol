// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployMoodMonkeyNft} from "../../script/DeployMoodMonkeyNft.s.sol";
import {MoodMonkeyNft} from "../../src/MoodMonkeyNft.sol";

contract DeployMoodMonkeyNftTest is Test {
    DeployMoodMonkeyNft public deployer;

    function setUp() public {
        deployer = new DeployMoodMonkeyNft();
    }

    function testConvertSvgToUri() public {
        // <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200"><text>Test</text></svg>
        // PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMDAiIGhlaWdodD0iMjAwIj48dGV4dD5UZXN0PC90ZXh0Pjwvc3ZnPg==
        string
            memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+PHRleHQgeD0iMCIgeT0iMTUiIGZpbGw9ImJsdWUiPlRFU1Q8L3RleHQ+PC9zdmc+";
        string
            memory svg = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500" height="500"><text x="0" y="15" fill="blue">TEST</text></svg>';
        string memory actualUri = deployer.svgToImageURI(svg);
        assertEq(actualUri, expectedUri);
    }
}
