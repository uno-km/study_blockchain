//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Inputvaluepurereturn {
    uint a= 1;
    uint b= 2;

    function test(uint c, uint d) public pure returns (uint) {
        return c + d;
    }
}


