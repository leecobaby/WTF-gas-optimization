// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Increment {
    function increment() external {
        uint256 num;
        num += 1;
    }

    function increment2() external {
        uint256 num;
        num = num + 1;
    }

    function increment3() external {
        uint256 num;
        num++;
    }

    function increment4() external {
        uint256 num;
        ++num;
    }

    function increment5() external {
        // 没有内存操作最省gas
        1 + 1;
    }
}
