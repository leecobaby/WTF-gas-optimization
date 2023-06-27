// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./Unchecked.sol";

contract UncheckedTest is Test {
    Unchecked public uncheck;
    Empty public empty;

    function setUp() public {
        uncheck = new Unchecked();
        empty = new Empty();
    }

    function testForNormal() public {
        uncheck.forNormal(10000);
    }

    function testForUnckecked() public {
        uncheck.forUnckecked(10000);
    }

    function testEmpty() public {
        empty.empty();
    }

    function testEmptyUnchecked() public {
        empty.emptyUnchecked();
    }
}
