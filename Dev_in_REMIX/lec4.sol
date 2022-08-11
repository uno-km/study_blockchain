// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec4{
    /*
        function 이름() public 
        {   // (public, private, internal, external)  변경가능
            //내용 함수에 들어갈 내용을 적는다.
        }

        함수를 정의할 때 3가지 경의 수 가 있다.
        1. Paramaeter 와 Return 값이 없는 경우
    */  
    uint public a = 3;
    function changeA1() public {
        a =5;
    }      

    //    2. Parameter는 있고, Return값이 없는 경우
    function changeA2(uint256 inVal) public {
        a  = inVal;
    }
    //    3. Parameter와 Return 값이 있는 경우    
    function changeA3(uint256 inVal) public returns(uint256){
        a  = inVal;
        return a;
    }
}