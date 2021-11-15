//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Delete {
    uint data = 1;
    uint []dataArray;

    function t1() public {
        uint x = data;
        delete x;
        //x를 0으로 초기화함
    }
}


