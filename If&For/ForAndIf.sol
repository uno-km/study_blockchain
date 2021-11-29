//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract ForAndIf {

    function Test() public pure returns (uint) {
        uint sum = 0 ;
        for (uint i = 0 ; i <= 100 ;i++) {
            if (i % 7 == 0)
                continue;

            sum = sum+i;
        }
        return sum;
    }
}


