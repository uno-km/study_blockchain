//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Non {
    uint a = 10;
    uint b = 20;

    function tmp() public view {
        uint c;
        c = a + b;
    }
}


