// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    10강은 상속애 댜해서 학습
    상속은 어느누가 자신의 재산을 어느 누구에게 아무대가 없이 주는 것이다.
    이와 같이 스마트 컨트랙 내에서도 다른 스마트컨트랙에게 상속을 시킬 수 있다.
    쉽게 예를 들면 부자 관계의 스마트컨트랙을 만들어서 보자
*/
contract Father{
    string public familyName = "Kim";
    string public givenName = "Uno";
    uint256 public money = 100;
    constructor(string memory givenNm) public {
        givenName = givenNm;
    }
    function getFamilyName() view public returns(string memory){
        return familyName;
    }
    function getGivenName() view public returns(string memory){
        return givenName;
    }
    function getMoney() view public returns(uint256){
        return money;
    }
}
/*
    아빠 스마트컨트랙을 보면 3개의 변수가 있다.
    첫번쨰는 성, 둘쨰는 이름, 마지막은 돈 이렇게 있다.
    각 함수는 각 변수를 get하는 함수들이있다.
    우리는 이 함수를 아들 스마트컨트랙에 상속시켜보겠다.
    상속하는 방법은 간단하다 
    바로 is 를 붙이고 상속받을 스마트컨트랙을 붙여주면된다.
*/
contract Son is Father("James"){   //아들 스마트 컨트랙이 아버지 스마트컨트랙을 상속 받는 것을 구현해보자
                            //즉 아들컨트랙을 배포 했을때, 함수들과 변수들을 접근할 수 있다.


}
/*
     위처럼 부자관계 스마트컨트랙을 만들어보자
     그리고 생성자인 컨스트럭터를 만들어서 아빠함수에 만들고
     아들함수에서 그 아빠함수를 가져오면 아빠함수를 상속받을때 () 해서 해당 생성자에 대해 값을 넣어야한다면 넣어주어야 한다.
*/