//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Encoding {
    function combineStrings() public pure returns (string memory) {
        string memory a = "Hello";
        string memory b = "World";
        string memory c = string(abi.encodePacked(a, b));
        return c;
    }

    function encodeString() public pure returns (bytes memory) {
        string memory a = "a";
        string memory b = "b";
        bytes memory someString = abi.encode(a, b);
        return someString;
    }

    function encodeStringPacked() public pure returns (bytes memory) {
        string memory a = "a";
        string memory b = "b";
        bytes memory someString = abi.encodePacked(a, b);
        return someString;
    }

    function stringConcat() public pure returns (string memory) {
        string memory a = "a";
        string memory b = "b";
        string memory c = string.concat(a, b);
        return c;
    }
}
