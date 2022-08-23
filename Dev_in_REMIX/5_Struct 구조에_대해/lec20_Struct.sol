// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    구조체란 ? 
    우리만의 타입을 만드는 것이다.
    
    그게 무엇인가?
    한번 예제를 작성하면서 설명을 하겠습니다.
*/
contract StructEx{
    struct Character{
        uint256 age;
        string name;
        string job;
    }
    /*
        케릭터라는 구조체를 만들었다.
        그 안에는 나이, 이름, 직업 이라는 3가지의 변수들이 있다. 
        이말은 즉슨 케릭터라는 구조체를 만들기위해서는 나이와 이름, 직업을 입력해주어야한다는 의미이다.
        이제 이것을 어떤식으로 생성을 하는지 알아봅시다.
    */
    function crateCharactor(uint256 inAge, string memory inName, string memory inJop) pure public returns(Character memory){
        return Character(inAge, inName, inJop);
    }
    /*
        현재 크리에이트케릭터라는 함수를 만들어 구조체를 생성하려한다. 당연히 이 함수에는 파라미터 값으로 나이, 이름, 직업
        등 필수 파라미터값이 필요하다. 그래서 이 구조체를 만들기 위해서는 당연히 케릭터를 써주시고 이 파라미터값을 넣어주면된다.
        return 을 하기위해 우리는 케릭터값을 리턴을 하고 당연히 기본 데이터타입이 아니니 memory 키워드를 넣어주었다.
        우린 이걸 컴파일하고 실행해보겠습니다.
        나이 29 이름 김은호 직업 개발자 이렇게 입력을 받았다.
        그러나 이렇게 반환받는것 보다 
        mapping이나 Array를 통해서 이 구조체값을 얻을 수 있다.
    */
    mapping(uint256=>Character) public charMapping;
    Character[] public charArr;
    /*
        당연히 우리는 매핑을 uint로 두었고,  안에 밸류값은 케릭터로 넣었다. 왜냐면 이것도 우리만의 타입이 된것이니까.
        그리고 배열을 선언할때도 [] 앞에 타입을 선언하는것이니까. 케릭터라는 구조체 타입을 넣어주었다.
        그리고 이름을 각각 지정해주었다.
        지난번처럼 우리는 매핑과 케릭터를 넣어보았다.
    */
    function createCharMapping(uint inKey, uint256 inAge, string memory name, string memory job) public {
        charMapping[inKey] = Character(inAge, name, job);
    }
    /*현재 매핑에 값을 넣는 값이다.*/
    function getCharMapping(uint key) public view returns(Character memory){
        return charMapping[key];
    }
    /*키값을 넣으면 반환한다.*/
    function createCharArr(uint256 age, string memory name, string memory job) public {
        charArr.push(Character(age,name,job));
    }
    /*하나씩 차곡차곡 생긴다..*/
    function getCharArr(uint256 idx) public view returns(Character memory){
        return charArr[idx];
    }
    /*
        각각 함수를 넣어주고 값을 넣어주면 
        밑에 tuple형식으로 나온다.
        이와같이 어레이 맵 모두 스트럭트 타입으로 값을 넣을 수 있다.
    */
}



    
