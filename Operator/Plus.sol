//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Plus {

    function plus() public pure returns (uint) {
        uint a = 1;
        uint b = 2;
        return a + b * 2;
    }

    function  rest() public pure returns (uint) {
        return 4 % 3;
    }
}


