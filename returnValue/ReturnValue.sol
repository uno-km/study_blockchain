//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Returnvalue {
    uint a = 10;
    uint b = 20;
    function tmp()public view returns(uint){
        return a+b;
    }
}
