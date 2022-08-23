// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    현재강의에서는 19강 Mapping과 Array에서 주의할 점 
*/
contract CautionEx{
    uint256 num = 89;
    //우선 여기 89라는 숫자가 있다. 이 값을 매핑과 어레이에 넣어보자
    /*
        우선 배포전에 아래 소스들을 설명하자면, 
        uint256 타입의 num을 89로 선언하였다.
        num*Add 각 함수를 누르면 해당 num값(89)이 해당 배열과 매핑에 들어간다. 
        그리고 showNumArray와 showNumMap을 눌러보았다. 
        그리고 showNum을 누르면 모두 89로 나타난다.
        
        이번엔 changeNum에 다가 99를 넣어서 89를 변경해보자
        showNum을 하면 99가 되었지만
        나머지 show*Map, Array를 누르면 다른 프로그래밍 언어에서는 당연히 99가 나와야하지만, 
        현재 솔리디티에서는 89가 나온다. 왜그런 것일까?
        그 이유는 매핑과 배열은 다른어어와 마찬가지로 "레퍼런스타입"으로 값들이 저장되어지는게 아니고,
        '그 당시의 값을 캡쳐해서 그 값만 저장하는 것이다.' 
        그롷기 때문에 넘값을 변경해도 업데이트가 되지않는다.
        그래서 우리가 따로 업데이트 함수를 만들어서 따로따로 업데이트를 해주어야한다.
    */
   mapping(uint256 => uint256) numMap;
   uint256[] numArray;
   
   function changeNum(uint256 _num) public{
       num = _num;
   }
   function showNum() public view returns(uint256){
      return num;
   }
   function numMapAdd() public{
       numMap[0] = num;
   }
   function showNumMap() public view returns(uint256){
       return numMap[0];
   }
   function UpdateMap() public{
       numMap[0] = num;
   }
   
   function numArrayAdd() public{
       numArray.push(num);
   }
   function showNumArray() public view returns(uint256){
       return numArray[0];
   }
   function updateArray() public {
       numArray[0] = num;
   }
}