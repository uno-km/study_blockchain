//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Logic {
    address payable creator;

    constructor () public {
        creator = msg.sender;
    }

    // TODO Add functions
    function kill() public {
        if (msg.sender == creator) {
            selfdestruct(creator);
        }
    }

    function tmp1() public pure returns(bool) {
        bool a = true;
        bool b = false;
        return a || b;
    }

    // a가 false이므로 b의 값과 상관없이 false를 리턴한다.
    function tmp3() public pure returns (bool) {
        bool a = false;
        bool b = true;
        return a && b;
    }

}


