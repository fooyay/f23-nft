// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// In order to call a function using only the data field of call,
// we need to include the following down to binary level:
// - the function name
// - the parameters we want to add

// Each contract assigns each function a "function selector"
// The function selector is the first 4 bytes of the keccak256 hash of the function
// signature. The function signature is a string that includes the function name and
// the parameter types (but not the return type).

contract CallAnything {
    address public s_someAddress;
    uint256 public s_amount;

    function transfer(address someAddress, uint256 amount) public {
        s_someAddress = someAddress;
        s_amount = amount;
    }

    function getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }

    function getDataToCallTransfer(address someAddress, uint256 amount) public pure returns (bytes memory data) {
        data = abi.encodeWithSelector(getSelectorOne(), someAddress, amount);
    }

    function callTransferFunctionDirectly(address someAddress, uint256 amount) public returns (bytes4, bool) {
        // This is how you would normally call the function
        // transfer(someAddress, amount);
        (bool success, bytes memory returnData) = address(this).call(getDataToCallTransfer(someAddress, amount));
        return (bytes4(returnData), success);
    }

    function callTransferFunctionDirectlyWithSignature(address someAddress, uint256 amount)
        public
        returns (bytes4, bool)
    {
        (bool success, bytes memory returnData) =
            address(this).call(abi.encodeWithSignature("transfer(address,uint256)", someAddress, amount));
        return (bytes4(returnData), success);
    }
}
