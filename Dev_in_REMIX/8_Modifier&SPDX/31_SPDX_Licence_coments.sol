// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;
/*
    SPDX-License_identifier : GPL-3.0
    우리가 솔리티디 학습을 하면서 매번 솔리디티 파일 맨 앞단에
    작성하는 폼이있다.
    >> // SPDX-License-Identifier: GPL-30 
    이렇게 작성하는걸 규칙으로 한다.
    사실 이 라이센스는 0.68이후로 도입이 되었다.
    이말은 즉슨, 0.68 버전 이전인 0.67버전 이전엔 이 라이센스를 넣지않아도 워닝메세지가 나오지 않는다.
    그래서 우리는 0.67을 컴파일을 해보겠다. 그랬더니 귀싵같이 사라진다.
    이 라이센스의 정보들은 솔리디티 다큐멘테이션에 있다.
    이것을 2가지로 압축 할 수 있다.
    1. 라이센스를 명시해 줌으로서 스마트컨트랙에 대한 신뢰감을 높일 수 있다.
    그리고 이것을 배포하게 되면 스마트컨트랙 자체가 오픈이 되기떄문에 저작권 관련되어서 문제가  있을수 있어서
    2. 스마트 컨트랙 소스 코드가 워낙 오픈되어있으니, 저작권과 같은 관련된 문제를 해소 
    그래서 Identifier를 명시해 준다고 한다.
    그리고 문서에 의하면 solidity의 컴파일에 대한건 SPDX 라이센스 아이덴티파이어를 써주는 것을 추천한다고 한다.
    그래서 SPDX 라이센스는 무엇이 있냐면 (link : https://spdx.dev/)링크 참고
    만약에 우리가 이런 라이센스를 사용하기 싫을 때는
    unlicensed 라고 작성하면된다.
    
    그리고 주석에 대해서 설명하겠다.
    주석이라는 것은 
    함수나 변수 그리고 스마트컨트랙에 대해서 
    특정한 값또는 기능들에 대해 설명을 달아주는것이다.
    우리는 왜 주석을 이용해서 설명을 해야하는가?
    우린 예를들어서 팀프로젝트를 하게되어 다른사람과 협업을 하게 되었을 때
    우리가 짠 코드를 다른사람도 보고 사용해야하기에 주석을 사용한다.
    그러기에 다른사람들이 해당 소스들을 이해할 수 있도록 주석으로 쉽게 설명을 해주는 것이다.
*/

contract SPDXEx1{
    /*
        add()함수는 9를 리턴한다.
        또는 파라미터는 어떤걸 받는다 등을 작성한다.
    */
    function add() pure public returns (uint256){
        return 4+5;
        // 이렇게 행단위로 주석을 달수 있다. 4+5=9; 이렇게 간단하게 작성가능하다.
    }

}