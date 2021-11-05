//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Shift {

    function shift() public pure returns (uint) {
        uint a =1;
        return a << 2;
    }
}


