//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Purereturn {
    uint a= 3;
    uint b= 3;

    function test() public pure returns (uint) {
        uint c = 3;
        return c;
    }
}