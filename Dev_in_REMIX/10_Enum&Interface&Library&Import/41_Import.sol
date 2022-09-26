// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0; 
/*
    Import에 대해 공부
    우리가 그동안 솔리디티를 공부하면서 한 솔리디티 파일안에 contract를 정의를 했다.
    ex:
    contract A{
    
    }
    contract B is A{

    }
    이렇게 B가 A를 상속한다면 위 와 같이 작성했다.
    그런데 만약 contract A가 다른파일에 위치해 있다면
    contract B는 a가 어디에있는지 몰라서 에러가 날 것이다.
    그래서 우리는 import를 써주어서 A의 주소를 넣어주어서 contract A가 어디에 있는지 알려줄수있다.

    예제를 통해 확인해보자.
    우리가 지난 수업 만들어본 라이브러리르와 contract 하나를 만들어보자.
*/

library SafeMath0{
    function add(uint8 a, uint8 b) internal pure returns (uint8){
        require(a+b>=a, "SafeMath : addition overflow");
        return a+b;
    }
}
/*
    아래의 Hi 컨트랙트는 간단하게 Hi 이벤트를 함수로 발생시키고 있고, 해당 하이는 
    입력된 Hello solidity를 출력하는것을 알 수 있다.

    그리고 41_importTest.sol 파일을 만들어서 해당 contract에 임포트랑 상속을 해보자.
*/
contract HiSolidity{
    event Hi(string str);

    function hi() public{
        emit Hi("Hello solidity");
    }
}