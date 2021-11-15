//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Fucntioninit {
    uint []a=[1, 2,3];

    function ex1() public pure {
        uint[]b = [1, 2,3]; //지역변수로 배열을 초기화 핼끼에 error 발생
    }
}


