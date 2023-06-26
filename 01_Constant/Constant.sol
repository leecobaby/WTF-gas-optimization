// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Constant {
    uint256 public constant varConstant = 1000;
}

contract Immutable {
    uint256 public immutable varImmutable = 1000;
}

contract Public {
    uint256 public variable = 1000;
}

contract Empty {
    function empty() public view {}
    function empty2() public view {}
}
