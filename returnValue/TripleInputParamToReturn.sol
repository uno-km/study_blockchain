//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Tripleinputparamtoreturn {

//SPDX-License-Identifier: UNLICENSED
    int a = 1;
    int b = 2;

    function tmp() public view returns (int) {
        int c = 10 ;
        return a + b + c;
    }

}


