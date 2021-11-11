//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Localpure {
    uint a = 1;
    uint b = 2;

    function test() public pure {
        uint c = 3;
        c;
    }

}


