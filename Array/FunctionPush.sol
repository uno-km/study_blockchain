//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Functionpush {
    uint []a; // 동적배열, 스토리지에 저장

//    function ex1() public view returns (uint) { // view 사용해야함을 유의
//        a.push(2); // 배열 a에 값 추가
//        a.push(3); // 배열 a에 값 추가
//        return a.length; // 배열 a의 길이 반환
//    }
    function ex1() public view returns (uint) { // view 사용해야함을 유의
        a.push(2); // 배열 a에 값 추가
        a.push(3); // 배열 a에 값 추가
        return a; // 배열 a 반환
    }
}


