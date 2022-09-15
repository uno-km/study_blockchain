// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0; 
/*
    call 함수 : 로우레벨 함수
    call은 지난 시간때 많이 사용했는데
    지금 집중적으로 공부해보자.
    call은 5가지 특징이있다.
    1. 이더를 송금할 수 있다.
    2. 외부 스마트컨트랙 함수 부를 수 있다.
    -> 이부분에대해서 예제 숙지
    3. 가변적인 가스 소비 가능 (반대로는 transfer와 send는 2300 가스 소비할 수 있었다.)
    4. 19년 12월 이후 , 이스탄불 하드포크로 인해 gas가격 상승에 따른 call 사용이 권장되었다.
    -> 가스가격이 미래적으로 오를수있고 2300가스로 턱없이 부족할 수 있어서.
    5. re-entrancy(재진입) 공격위험이 있기에, check_effects_interactions_pattern 사용을 하였다.

    그렇다면 이 중점적으로 는 2번 특징과 1번특징을 특징적으로 알아보겠다.

*/
contract add{
    /*
        2개의 이벤트가 있고, 2개의 이벤트가 사용되는 폴백함수가 있다.
        리시브 폴백함수는 스마트컨트랙에서 이더를 받을 수 있도록 해놓았다.
        따라서 이는 add 는 리시브를 통해서 이더를 받을 수 있다.

        폴백함수의 경우는 caller가 add에 없는 스마트컨트랙을 호출 한경우 폴백 이 작동한다.
    */
    event justFallback(string str);
    event JustRecive(string str);
    function addNumber(uint256 num1, uint256 num2) public pure returns(uint256){
        return num1+num2;
    }
    fallback() external payable{
        emit justFallback("JustFallback is called");
    }
    receive() external payable {
        emit JustRecive("JustReceive is called");
    }
}
contract caller{
    /*
        transferEther함수는 
        콜함수를 이용해서 이더를 보내는 것을 알 수 있다.
        그리고 이 파라미터는 to를 받는데 이더송금받을 주소를 받는다.
        그리고 이 함수자체가 이더를 송금하는 방식이라 payable을 붙였다.
        그리고 call 함수는 0.7버전 이상의 버전의  call형식이다.
    */
    event calledFunction(bool success, bytes output);

    //1.송금하기
    function transferEther(address payable to) public payable{
        (bool success,) = to.call{value:msg.value}("");
        require(success, "failed to transfer ether");
    }
    /*
        callMethod2개의 uint256을 받고있다. 이 이유는 우리가 부르려는 함수가 addNumber라는 함수라서 2개의 파라미터값이 필요하다.
        그래서 callMethod가 필요해서 2개의 파라미터가 필요하다.
        callMethod를 잘보면 처음 보면 많이 어렵게 생각할 수 있다.
        call 하는 함수를 부르는데 그 부르는 함수는 
        abi.encodeWithSignature("addNumber(uint256,uint256)", num1,num2)
        이런식으로 불러야한다.

        여기 보면 abi을 사용했다.
        우리가 부르려는 컨트랙트 주소, 지갑주소를 받아서
        _contractAddr 변수로 받고,
        숫자들도 받아서 
        _contractAddr.call을 사용했고 괄호를 열어서 abi.encodeWithSignature함수를 호출하고
        해당 () 괄호 안에 커텐션에 함수이름을 써주고 그 함수의 타입을 써주는 것이다.
        그리고 우리는 그 타입안에 들어갈 변수들을 , 를 이용해서 넣어준다. 
        이때 num1, num2 대신 하드코딩을 이용하거나 다른 작업을 통해서 해당 값을 넣어주어도 된다.
    */
    function callMethod(address _contractAddr,uint256 num1, uint256 num2) public{
        (bool success, bytes memory outputFromCalledFunction) = _contractAddr.call(
        abi.encodeWithSignature("addNumber(uint256,uint256)", num1,num2)
        );
        require(success,"failed to transfer ether");
        emit calledFunction(success,outputFromCalledFunction);
    }
    /*
        이런식으로 외부 스마트컨트랙트 함수를 가져와서 사용하는 것을 알 수 있디ㅏ.
        우리는 기존의 사용하던건 기존의 success 불리언 값이었는데 , 함수의 값들은 byte 메모리 값이다.
        바이트메모리 값은 무엇이냐면, addNumber가 작동하고 return  이 된 값이다.
        리턴이 된 num1+ num2 이 바이트화 되어서 리턴이 되는것이다.
        즉 다시말해서 우리가 이더를 보낼때, 바이트 메모리를 출력할 필요가 없기에 우리가 공란으로 놓았었다.
        그리고 송금여부에 따라서 require 에러를 내느냐 안내느냐 여부를 따졌는데, 
        함수의 리턴값을 받기위해 바이트 메모리를 쓴것이다.
        따라서 해당 함수는
        call 이 잘작동했는가 안했는가, 그리고 addNumber의 리턴값이 나온다.
        그래서 해당 이벤트가 출력이된다.

        그럼 abi 가 뭐길래 저렇게 작동시키는 것일까?
        솔리디티 다큐멘테이션에 의하면 이더리움 환경 안에 의해서 스마트컨트랙의 상호작호작용의 표준방법이라고 설명하고있따.
        데이터가 코드화 되어있고, 이 설명이 되어있다
        그리고 abi 오브젝트 안에는 encodeWithSignature가 있따.
        이 메서드를 이용해서 외부 스마트 컨트랙의 함수를 호출한다고 한다.

        우리는 추가적으로 이더를 보내면서 스마트컨트랙에 없는 함수를 호출해보자.
        그러면 애드의 함수엔 폴백이 실행될것이다.
    */
    function callMethodFallback(address _contractAddr) public payable {
        (bool success, bytes memory outputFromCalledFunction) = _contractAddr.call{value:msg.value}(
        abi.encodeWithSignature("Nothing()")
        );
        require(success,"failed to transfer ether");
        emit calledFunction(success,outputFromCalledFunction);
    }

}
