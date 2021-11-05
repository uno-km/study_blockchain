//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Enum {
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

    enum F {
        apple,
        orange,
        mango,
        pear
    }
    F f;
    F constant defalutF =F.apple;

    function setF() public {
        f = F.mango;
    }

    function getF() public view returns(F) {
        return f;
    }

    function getF2() public pure returns (uint) {
        return uint(defalutF);
    }
}


