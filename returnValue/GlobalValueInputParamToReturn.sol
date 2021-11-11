//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Globalvalueinputparamtoreturn {
    int c = 10;

    function tmp(int a, int b) public view returns (int) {
        return a + b + c;
    }

}


