// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0; 
/*
    library : library는 우선 기존의 만들던 스마트컨트랙과  다른형태의 contract이다. 
    이 라이브러리를 사용하면 
    [1]이점
    1. 재사용성          
    2. 가스소비절감      
    3. 데이터 타입 적용 

    쉽게 말해서 여러개의 스마트컨트랙이 있는데,  스마트컨트랙들에게는 공통으로 쓰이는 함수들이 있다고 가정해보자.
    그 공통으로 사용되는 함수들을 라이브러리 안에 넣는것이다.
    그렇게 된다면 여러가의 스마트컨트랙들은 그 라이브러리를 사용하므로 공통적인 함수들을 사용할 수 있따.
    이말인 즉슨 여러개의 스마트컨트랙들은 공통의 함수들을 정의할 필요가 없고, 이에 따라서 각 스마트컨트랙트의 소스들은
    짧아질것이고, 배포하는 가스의 양도 줄어들게된다.그래서 library 함수의 재사용, 스마트컨트랙 가스소비절감, 등을 눈에띄게 가능하다.

     
    [2]단점
    1. fallback함수 불가 : fallback함수를 라이브러리 안에 정의를 못하기에, 이더를 가지고 있을 수 없다.
    2. 상속 불가
    3. payable 함수 정의 불가.

    이더를 받을 수 없어서 1,3 이 불가능합니다.
    예제를 통해서 확인해보겠습니다.    
*/
library SafeMath{
    /*
        우선 이 라이브러리는 overflow방지하는 라이브러리이다.
        사실 이 0.8 전으로, overflow가 되냐 안되냐로 나뉜다.
        0.8 전에는 overflow가 되었다. 
        overflow 란? : uint8의 범위는 0~255까지 인데, 만약 우리가 257 넣게 된다면, 255밖에 표현이 안되니까
        0부터 다시돌아서 0->1 즉 1이 되는것이다.
        예를들어서 256을 넣는다면 0되는것이다. (한바퀴돌아서)
        이것의 반대는 underFlow이다.

        그러면 이 add라는 함수가 있는데, a와 b가 합쳐졌을 때
        만약 uint8의 값을 벗어났을때 overflow가 되면 에러가 생성되는 함수가 있다.
        그리고 리턴값도 uint8이다.
        그리고 각 파라미터  a,b도 uint8인것을 알 수 있따.

        그렇다고 해도 overflow가 된다고 하더라도, uint8 이 0~255인데, 우리가 256을 넣는다면
        솔리디티 자체에서 에러가 납니다.
        이말은 즉슨 a와 b가 더해졌을떄,  255를 넘으면 overflow가 되는것인데, 
        0.8버전 이후로는 uint8이 255를 넘으면 당연히 에러가 발생하게 하였다.
        우리는 현재 require를 통해서 overflow를 조절하고 있다.
        현재 a+b>=a가 참이여야지 에러가 나지않고 정확히 나온다.
        만약 a또는  b에 미리 256이상의 값을 넣으면 또 에러가 발생할것이다.
    */
    function add(uint8 a, uint8 b) internal pure returns (uint8){
        require(a+b>=a, "SafeMath : addition overflow");
        return a+b;
    }

}
contract UserLibrary{
    /*
        하단처럼 using SafeMath for uint8 이렇게 했는데, 여기 데이터 타입붙인것처럼 좀더 데이터타입에 대해
        쓸수있다는것을 알 수 있따.
        그리고 a라는 변수가 있고, a라는 변수에 x,y값의 합이 들어가는것을 알 수 있따.
        1. x.add(y) 식으로 오버플로오 체크를 할 수 있으며,

        2. a = SafeMath.add(x,z);
        이렇게 사용할 수 있따.
        이제 이것을 컴파일할것인데, 한번 0.8이전 버전으로 한번해봐야한다.
    */
    using SafeMath for uint8;
    uint8 public a ;
    function becomeOverflow(uint8 x, uint8 y) public{
        a = x.add(y);
        // a = SafeMath.add(x,z);
    }
}