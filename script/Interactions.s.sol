// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodMonkeyNft} from "../src/MoodMonkeyNft.sol";

contract MintBasicNft is Script {
    string public constant MADMONKEY =
        "https://ipfs.io/ipfs/QmbCPVaqBUjPbK9BxG1bvNUeHEauSjnxNiGuR4KWqHpay9?filename=madMonkey.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(MADMONKEY);
        vm.stopBroadcast();
    }
}

contract MintMoodMonkeyNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodMonkeyNft",
            block.chainid
        );
        mintMoodMonkeyNftOnContract(mostRecentlyDeployed);
    }

    function mintMoodMonkeyNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodMonkeyNft(contractAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodMonkeyNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodMonkeyNft",
            block.chainid
        );
        flipMoodMonkeyNftOnContract(mostRecentlyDeployed);
    }

    // TODO: Allow user to pass in the nftIndex.
    function flipMoodMonkeyNftOnContract(address contractAddress) public {
        uint256 nftIndex = 0;
        vm.startBroadcast();
        MoodMonkeyNft(contractAddress).flipMood(nftIndex);
        vm.stopBroadcast();
    }
}
