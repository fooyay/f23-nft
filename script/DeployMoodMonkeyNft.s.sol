// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {MoodMonkeyNft} from "../src/MoodMonkeyNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodMonkeyNft is Script {
    function run() external returns (MoodMonkeyNft) {
        string memory happyMonkeySvg = vm.readFile("./img/happy_monkey.svg");
        string memory sadMonkeySvg = vm.readFile("./img/sad_monkey.svg");

        vm.startBroadcast();
        MoodMonkeyNft moodMonkeyNft = new MoodMonkeyNft(svgToImageURI(sadMonkeySvg), svgToImageURI(happyMonkeySvg));
        vm.stopBroadcast();
        return moodMonkeyNft;
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string.concat(baseURL, svgBase64Encoded);
    }
}
