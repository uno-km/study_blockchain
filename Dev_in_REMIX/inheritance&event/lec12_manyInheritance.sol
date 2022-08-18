// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
   12강 : 두개 이상 상속하기
    2개이상 상속을 받는 것을 학습하는것이다.
    예시로는 보통 가족처럼 아빠와 엄마로부터 상속받는 아들 스마트컨트랙을 만들어서 실습을 진행하겠다.
*/
contract Father{
    uint256 public fatherMoney = 120;
    string public fahterName = "Kim";
    function getMoney() public view virtual returns (uint256){
        return fatherMoney;
    }
    function getFatherName() public  view  returns (string memory){
        return fahterName;
    }
}
contract Mother{
    uint256 public motherMoney = 200;
    string public motherName = "Hwang";
    function getMoney() public view virtual returns (uint256){
        return motherMoney;
    }
    function getMotherName() public  view  returns (string memory){
        return motherName;
    }
}
/*
    이때 엄마 컨트랙트와 아빠 컨트랙에 각각 변수들과 함수들을 선언했지만, 공통적으로 getMoney() 함수를 선언해 두었다.
    만약 아들에 둘다 상속을 하고 해당 함수를 호출하면 어떻게 될까?
    => 둘다 상속받을때 둘이 함수이름이 겹친다고 한다. 그래서 그것을 오버라이딩 하라고 컴파일러 오류가 난다.
     그래서 오버라이딩을 해주기 위해서 그 함수에 virtual 을 추가해주고 
    아들 컨트랙트에 오버라이드를 해준다. 그리하여 아래의 컨트랙트처럼 작성하면 된다.
*/
contract Son is Father , Mother{ //둘다 상속받을때 " , "를 이용해서 둘다 상속을 받는다. 
    function getMoney() public  view override(Father, Mother) returns (uint256){
        return  fatherMoney+motherMoney;
    }
}
