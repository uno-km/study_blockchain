// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    오버라이딩에 대한 학습 :
    오버라이딩이란 ? 상속을 받아서, 함수를 쓰게 된다면 함수는 우리것으로 특색있게 변형시키는 것이다.
    지난 강의를 가져와서 본다면 아빠함수와 아들함수를 가져왔을때 
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
    function getMoney() view virtual public returns(uint256){//오버라이딩을 할 곳에 virtual을 넣어주면된다. 위치는 관계 x
        return money;
    }
}
contract Son is Father("Jung"){
    /*
        여기 아들 함수 중 getMoney는 우선 아빠 함수와 이름을 무조건같게해야한다. 대신 내용만 달라야한다. 
        그리고 override를 붙여주어야한다. virtual 의 위치에 오버라이드를 명시해야한다.
        이것은 솔리디티에서 꼭 지켜주어야한다.

    */
   uint256 public earning = 0;
   function work(uint256 inUint)  public {//월급을 받는걸 묘사했다.
       earning = earning + inUint;
   }
   function getMoney()  view override public returns(uint256){
       return money+earning; //여기보면 머니+어닝 이라고 되어있다. 이 얼닝의 변수는 아들이 일을해서 번돈으로 예를 들었고,
                                //그래서 아들이 돈을 벌며너 그 머니와 얼닝이 합쳐진다고 구상했다.
   }
}
/*
    지난 시간에서 컨스트럭트/생성자도 만들고 해당 상속받는 곳에서 생성자를 정의하는 것도 다 해보았다.
    이 아버지가 아들에게 100만원을 줄때, 아들이 백만원을 상속받았으니까 소비나 재태크를 할 수 있는 것이다.
    결국 그것을 상속받아 아들쪽에서 수정을 할 수 있는것이다.
    그래서 그 돈을 우리는 "오버라딩" 화 했다고 말하고, 아들부분에 적용시키는 것이다.
    ===
    추가적으로 아빠의 컨트스럭트를 상속받았지만  다른방법으로 상속받을 수 있다. 하단
*/
contract Daughter is Father{
    constructor() Father("Alice"){

    }
}
/*
    위처럼 파더컨트랙트에서 바로 생성자를 정의하는게 아니고 
    안으로 따로 뺴서 생성자를 상속받아 함수 내부에서 선언해주는 방법도 있다.
*/