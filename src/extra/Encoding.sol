//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Encoding {
    function combineStrings() public pure returns (string memory) {
        string memory a = "Hello";
        string memory b = "World";
        string memory c = string(abi.encodePacked(a, b));
        return c;
    }
}
