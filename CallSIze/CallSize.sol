//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Callsize {
    uint a = 1;
    uint b = 2;

    function  test() internal view returns (uint) {
        return a; // 스토리지에 저장된 변수
    }
}


//실행은 되지만, 
//함수 호출범위를 적지 않아 경고가 발생한다.
