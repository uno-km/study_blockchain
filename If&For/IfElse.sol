//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Ifelse {

    function Test(uint a) public pure returns(bool) {
        if (a % 2 == 0) {
            return true;
        } else {
            return false;
        }

    }

    function Test2(uint a, uint b) public pure returns(bool) {
        if (a / b >= 1) {
            return true;
        }
        else{
            return false;
        }
    }
}


