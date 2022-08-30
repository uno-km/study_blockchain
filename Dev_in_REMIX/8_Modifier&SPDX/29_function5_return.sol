// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    이번강의에서는 함수의 리턴명을 써주는 방법을 학습
    지난강의에서 try/catch문을 쓰면서 함수의 리턴명을 써주었다.
    그  리턴명을 이용해서 리턴을 바로해주었는데
    ex : 
        function playTryCatch(uint256 inNumb) public returns (uint256, bool){
            try this.simple(inNumb) returns (uint256 val){
                return(val, true);
            }catch{
                emit catchOnly("catch!!!","ErrorS!!");
                return (0,false);
            }
        }
    이렇게 위처럼 returns (uint256 val) 의 리턴값 val을 그대로 또 try문의 return 에서 사용한것을 볼 수 있다.

*/
contract returnNaming{
    /*
        이 강의를 위해 함수 2개를 만들었다. add1, add2이다.
        2개의 다른점은 returns 명이 있고 없고이다.
        그래서 이 add1의 함수는 num1, num2가 서로 합하여 total이라는 변수가 정의되고 그것을 리턴한다.
        
        그리고 add2처럼 리턴명을 해주는 이유는 : 예를들어 리턴할 때 값들이 많아진다면 , 나중에 코드를 봤을때 헷갈릴수 있다.
        ex : function add1(uint256 num1, uint256 num2) public pure returns (uint256, uint256, uint256, uin256)
        그래서 우리는 리턴명을 정의해주는것이 정신건강에 좋다. 나중에 봤을떄 쉽게쉽게 기억할 수 있다.
        실행하면 둘다 이상은 없다.
        
    */
    function add1(uint256 num1, uint256 num2) public pure returns (uint256)
    {
        uint256 total = num1 + num2;
        return total;
    }

    function add2(uint256 num1, uint256 num2) public pure returns (uint256 total)
    {
        total = num1 + num2;
        return total;
    }
}