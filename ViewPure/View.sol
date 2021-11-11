//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract View {

    uint a = 1;
    uint b = 2;

    function test() public view {
        a;
    }
}
//상태변수만 사용, view 사용해야함

