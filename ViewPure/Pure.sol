//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Pure {
    uint a = 1;
    uint b = 2;

    function test() public pure returns (uint) {
        return a;
    }
}


