//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Storage2 {
    uint []a; // 스토리지에 저장
    uint []b= new uint[](2); // 메모리에 저장

    function ex1(uint len) public pure {
        uint []memory d; // 스토리지에 저장
    }
}


