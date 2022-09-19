// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0; 
/*
    interface란? : 스마트컨트랙에서 정의되어야할 필요한 것들
    예를들어서 여러개의 스마트컨트랙이 있고 interface안에 특정한 함수가 있다.
    그리고 모든 스마트컨트랙에 이 interface 를 적용했다면 모든 스마트컨트랙은 interface가 정의한 특정한 함수를 다 가지고 있다.
    
    1. interface 내의 함수는 external로 표시
    2. interface 내의 함수는 enum, structs 사용 가능
    3. 변수, 생성자 불가(constructor x )
    
    우린 우선 인터페이스에 대해 예제로 확인해보자.
*/
interface ItemInfo{
    /*
        interface를 우선보면은
        item이라는  스트럭트가 있다.
        그리고 이 함수 2개가 있다.
        이 함수끝에는 무조건 external이 붙어야한다.
        그리고 이것이 다른 스마트컨트랙에 사용되어진다면
        해당 스마트컨트랙에서 함수를 정의를 꼭 해주어야한다.
        만약 함수정의를 빼먹거나 선언을 안해주면  에러가 생긴다.
        그래서 반드시 interface를 적용했다면 함수와, 해당 함수의 파라미터값과 리턴값을 동일하게 사용해야한다.
        그리고 interface를 정의할때는 overide 키워드를 해당 선언한 함수뒤에 넣어주어야한다.
        그래서 interfaceEx 라는 함수는 is 를 통하여 interface를 적용받았다.

    */
    struct item{
        string name;
        uint256 price;
    }
    function addItemInfo(string memory name, uint256 price) external;
    function getItemInfo(uint256 idx) external  view returns(item memory);
}
contract interfaceEx is ItemInfo {
    /*
        이 스마트 컨트랙에서 is ItemInfo로 ItemInfo 인터페이스를 주입시켰다.
        그러면 바로 함수 2개에 대해 정의를 하지않아서 바로 오류부터 발생한다.
        그래서 인터페이스 주입을 했다면 바로 넣어주어야한다.
        그렇기 때문에 함수의 명과 그 함수안의 파라미터값과 그 리턴값을 똑같이 써주어야한다.
        그리고 함수를 정의할땐 키워드 override를 붙여주어야한다.
        그래서 interfaceEx는 is를 통하여 interface를 적용받았다.
        그리고 상속받은 interface내에  item 스트럭트가 있어서
        바로 사용할수가있다. 이말은 즉슨 아이템인포라는 interface를 적용받는 스마트컨트랙들은
        이런식으로 사용할 수 가있다.
        그리고 addItemInfo는 interface의 함수중 하나를 상속받은 것인데, 
        이 이름과 가격을 해당 스마트컨트랙 내의 item[]에 넣는다.
    */
    item[] public itemList;
    function addItemInfo(string memory name, uint256 price) override public{
        itemList.push(item(name,price));
    }
    function getItemInfo(uint256 idx) override public view returns(item memory){
        return itemList[idx];
    }
}