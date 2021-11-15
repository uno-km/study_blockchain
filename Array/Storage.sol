//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Storage {
    uint []a; // 스토리지에 저장
    uint []memory c ; //  상태변수를 메모리에 저장

    function ex1() public pure {
        uint[]memory b; // 메모리에 저장
    }

}


