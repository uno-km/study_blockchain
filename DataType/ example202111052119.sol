//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract test {

    function arith1() public pure returns (uint) {
        uint    a = 3;
        uint    b = 2;
        return a * b;
    }

    function arith2() public pure returns (uint) {
        uint a = 10;
        uint b = 2;
        return a / b;
    }

    function arith3() public pure returns (uint) {
        uint a = 10;
        uint b = 2;
        return a - b;
    }

    function arith4() public pure returns (uint) {
        uint a = 10;
        uint b = 2;
        return a + b;
    }

    function arith5() public pure returns (uint) {
        uint a = 10;
        uint b = 2;
        return a * b;
    }
}


