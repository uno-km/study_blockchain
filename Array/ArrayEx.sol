//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Arrayex {
    // 고정 배열
    uint[5] tmp1 = [1, 2,3,4,5];
    // 동적 배열
    uint[] tmp2;

    function a() public view returns (uint) {
        uint res = 0;
        for (uint i=0;i < tmp1.length;i++) {
            res = res+tmp1[i];
        }
        return res;
    }

    function by() public payable returns (uint) {
        tmp2.push(1);
        tmp2.push(2);
        uint sum =0;
        for (uint  i = 0 ; i < tmp2.length ;i++) {
            sum = sum +tmp2[i];
        }
        return sum;
    }
}


