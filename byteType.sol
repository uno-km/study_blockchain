//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Bytetype {

//bytes8는 8파이트
    function tmp() public pure returns (bytes8) {
        bytes8  b= "hi";
        return b;
    }

//bytes는 동적 크기의 바이트 배열
    function tmp2() public pure returns (bytes) {
        bytes memory a = 'hi';
        return a;
    }
}


