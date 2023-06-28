// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Error {
    error NotOwner();
    error NotOwnerCarryInfo(bytes info);

    function errorRevert() external pure {
        if (true) revert NotOwner();
    }

    function errorRevertCarryInfo(bytes calldata info) external pure {
        if (true) revert NotOwnerCarryInfo(info);
    }

    function errorRequire() external pure {
        require(false, "NotOwner");
    }

    function errorAssert() external pure {
        if (true) assert(false);
    }
}
