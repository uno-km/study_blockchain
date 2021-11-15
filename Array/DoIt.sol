//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Doit {
    uint[] public values;

    function addVal(uint value) public {
        values.push(value);
    }

    function count() public view returns(uint) {
        return values.length;
    }
}


