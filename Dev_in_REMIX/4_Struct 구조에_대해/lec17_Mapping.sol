// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    17강에서는 mapping을 학습한다.
    mapping이란 ?
    mapping은 key와 value로 이루어져 있다.
    우리가 특정한 키값을 3이라고 정의하고, 그 3에 대응하는 value 값을 6이라고 가정했을때
    우리가 이 mapping에 3을 넣으면 밸류값 6을 반환 받는 형식이다.
    이와 같이 mapping은 특정한 key를 넣어주면 그에 대응되는 value값을 반환 받게 해주는 것이다.
    그럼 우리는 이제 mapping을 정의해보자.
*/
contract mappingClass{
    mapping(uint256=>uint256) private ageList;//우리는 현재 에이지리스트라는것을 매핑해 보았다.
        // ^^^^^^^^이건 키값의 타입이고, 그 뒤는 value값의 타입이다.> 자바의 선언부랑 비슷하다. 
        // 이 뜻은 키값을 숫자로 받겠고 밸류값도 숫자로 반환 된다는 뜻이다. 접근제한자도 써주어야하는데
        // 여기선 private를 사용해보자. 그리고 그 뒤는 mapping의 명을 정의한다.
        // 이제 매핑을 정의했으니, 키값과 밸류값을 넣고 우리가 특정 키값을 받았을때 어떤식으로 밸류값이 반환되는지에 대해 알아보자.
       /*
            아래 두개의 함수는 겟에이지리시트와 셋에이지 리스트이다.
            이름에서 풍겨오는 의미처럼 setAge리스트는 키값과 밸류값을 넣어주는 것이다.
            겟 에이지는 밸류값을 리턴받는 함수이다.
        */
        function setAgeList(uint256 index,uint256 age) public {
            ageList[index] =  age;
        } 
        /*
            여기서 셋에이지 입력값을 보면, 인덱스는 키값이, 에이지는 밸류값을 나타낸다.
            그리고 위에 보면 uint256이 있기때문에 키값과 밸루값이 모두 uint256이다.
            그리고 에이지리스트 키값과 밸류값을 정의하기 위해서는 ageList를 써주고 대괄호안에 키값을 넣어주고
            "=" 를 통해 그에 맞는 밸류값을 넣어준다.
        */
        function getAge(uint256 index) public view returns(uint256){
            return ageList[index];
        }
        /*
            겟에이지의 경우 키값을 받으면 그에 상응하는 밸류값을 출력받을 수 있다.
            한번 컴파일해서 배포후 실행을 해보자.
            이때 인덱스에 특정숫자와 age에 숫자를 넣고 getAge를 통해 매핑된 값들을 느껴보자.
            그리고 한가지 참고해야할 점!!!
            *중요*
            이런 mapping은 키와 밸류로 이루어져 있어 Length를 구할 수 가 없다.
            그래서 우리는 키값이 무엇인지만 알아두면 바로 밸류값을 찾아서 쓸수 있다.
            그리고 좀더 나아가서 다른 타입의 키값과 다른타입의 밸류값을 한번 정의해보자. 
        */
        mapping(string=>string) private nameList;
        function setNameList(string memory key,string memory value ) public {
            nameList[key] =  value;
        } 
        function getNameList(string memory key) public view returns(string memory){
            return nameList[key];
        }

        mapping(string=>uint256) private priceList;
        function setPriceList(string memory key,uint256 value ) public {
            priceList[key] =  value;
        } 
        function getPriceList(string memory key) public view returns(uint256){
            return priceList[key];
        }
        /*
            여기보면 셋에이지 말고도 셋 프라이스, 셋네임을 지정해주었따.
        */
        mapping(string=>mapping(string=>uint256)) private mapInMap;
}