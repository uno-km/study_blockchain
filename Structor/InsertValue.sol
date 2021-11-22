//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Insertvalue {
    struct St{
        uint no;
        string name;
       
    }
    St[] stClass1;
    
    St kim=St(20,"kim")
    stClass1.push(kim);
    //이 두줄을 한줄로 줄일수있다.
    stClass1.push(St(20,"kim"));
}
