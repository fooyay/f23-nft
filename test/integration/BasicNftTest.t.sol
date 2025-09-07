// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant MADMONKEY =
        "https://ipfs.io/ipfs/QmbCPVaqBUjPbK9BxG1bvNUeHEauSjnxNiGuR4KWqHpay9?filename=madMonkey.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public {
        string memory expectedName = "MadMonkey";
        string memory actualName = basicNft.name();
        assertEq(actualName, expectedName);
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(MADMONKEY);

        assert(basicNft.balanceOf(USER) == 1);
        assertEq(basicNft.tokenURI(0), MADMONKEY);
    }
}
