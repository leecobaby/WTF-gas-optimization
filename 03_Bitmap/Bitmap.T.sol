// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./Bitmap.sol";

contract BitmapTest is Test {
    Bitmap public bitmap;

    function setUp() public {
        bitmap = new Bitmap();
        testSetDataWithBoolArray();
        testSetDataWithBitmap();
    }

    function testSetDataWithBoolArray() public {
        bitmap.setDataWithBoolArray([true, true, true, true, true, true, true, true]);
    }

    function testSetDataWithBitmap() public {
        bitmap.setDataWithBitmap(255);
    }

    function testReadWithBoolArray() public {
        bool res = bitmap.readWithBoolArray(0);
        console2.log("res:", res);
    }

    function testReadWithBitmap() public {
        bool res = bitmap.readWithBitmap(3);
        console2.log("res:", res);
    }
}
