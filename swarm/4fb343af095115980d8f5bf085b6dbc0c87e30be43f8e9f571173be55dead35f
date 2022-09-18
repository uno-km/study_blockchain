// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0; 
/*
    Call Vs Delegate Call
    Delegate Call :
    1. msg.sender 가 본래의 스마트 컨트랙 사용자를 나타낸다.
    2. delegate call 이 정의된 스마트컨트랙 (즉 caller) 이 외부 컨트랙의 함수들을 마치 자신의 것처럼 사용(실질적인 값도 caller에 저장)
        caller 스마트컨트랙으로 저장이 된다는 것이다.
        즉 이렇게 실직적인  caller 스마트컨트랙에 저장이 되기 위해서는 외부스마트컨랙과 내부 스마트컨트랙의 변수가 같아야 한다.
        즉 이렇게 특징을 설명했는데 이해가 안갈 수 있따.
    예를들어 김은호,A,B가 있다.
    김은호가 스마트컨트랙 A의 함수 callA()를 실행시켰다. 그럼 해당 callA()의 msg.sender 에는 김은호의 주소가 나온다.
    이 후에 callA()함수가 돌다가 스마트컨트랙 B의 changeB()라는 함수를 호출했다고 치자.
    그럼 changeB() 에서 msg.sender 가 호출된다면 해당 값에는 스마트컨트랙 A의 주소가 나오게된다.
    그럼 딜리게이트 콜은 어떤가?
    동일하게 김은호,A,B가 있다고하자.
    김은호가 스마트컨트랙 A의 callA() 를 호출했다.
    스마트컨트랙 A의 msg.sender의 주소는 동이랗게 김은호의 주소가 나온다. 
    그리고 나서 callA가 돌다가 스마트 컨트랙 B 의 changeB()를 만나  msg.sender의 값에는 김은호의 주소가 나온다.
    delegate call 일경우는 스마트컨트랙B에서 다시 스마트컨트랙 A 로 돌아온다.

    그래서 call과 delegate call 을 비교해서 보자면
    callA() 가 불러짐에 따라서 스마트컨트랙B의 값은 변경시점이 달라진다.

    다시 특징을 보자면 delegate call의 msg.sender 는 본래의스마트컨트랙 사용자르 나타낸다.

    특징 2번을 다시보자면 : caller는 스마트컨트랙트 A로 가져와서 처리한다.

    실질적인 값도 caller에 저장된다.
    그리고 이 조건은 당연히 변수를 동일하게 모두 가지고 있어야한다.

    진짜 최종적으로 설명하면
    - delegate call을 이용하면 스마트컨트랙 A, 스마트컨트랙 B의 msg.sender값이 같고, 
    함수를 사용해도 호출자 스마트컨트랙 A의 변수가 B의 함수를 통해 변하는것볼 수 있다.
    걍 call은 폭포수느낌임
    그러면 우리는왜 delegate call 이 필요할까?
    upgradable smart conract때문이다.
    고객과 스마트컨트랙A와 스마트컨트랙 B가 있다.
    고객들이 물건들을 사고, 계산을 할때 스마트컨트랙 A를 통해 스마트컨트랙B라는 적립해주는 함수를 통해 포인트를 5씩 적립해준다하자
    그런데 회사방침이 바뀌어서 5가 3으로 줄었다고 할때
    스마트컨트랙 a와 b는 이미 블록체인상에 배포가 된상태다.
    이미 개발자가 와도 a,b의 함수나 그런것들을 바꿀수가 없다.
    )) 이유는 : 블록체인 특징중 하나가 위변조가 불가능해 누가와도 코드를 변경할 수 없다.
    그렇기 때문에 5->3으로 소스상으로 수정을 불가하다.
    마지막방법은 a,b를 재배포하는방법인데.

    여기엔 문제점이있다. 
    기존 a,b스마트컨트랙에는 유저들이 기존에 사용한 사용자 정보들이 저장이 되어있는데
    새롭게 재배포하면 모든 정보들이 초기화된다.
    모든정보들이 스마트컨트랙이 있으니 그래서 스마트컨트랙을 모두 긁어오자니 그 비용적인 측면도 만만치 않다.

    두번째는 고객들은 a의 주소를 통해 b를 실행시켰는데. a의 주소가 또 새롭게 배포가 되니까 영향을 받을 수 밖에없다.
    그럼 또 고객들에게 새로운 a의 주소를 알려주어야 한다. 이또한 비용이다.
    그래서 우리는 upgradable 스마트컨트랙 패턴을 사용해야한다.

    즉 이것은 delegate call을 사용하는 것인다.
    delegate를 사용한다고한다면 a,b가 돌아가면
    b의 적립하는 기능이 a에 저장이된다. 그리고 b는 그냥 주요로직이고 껍데기만된다.
    실질적인 값은 a에 저장된다.
    그리고 회사방침이 바뀌어서 5->3 으로 바뀌었을때, 
    우리는 스마트컨트랙b 를 버리고, 새롭게 스마트컨트랙 b2를 만들어서
    그 b2에는 적립포인트 3이 있어야한다. 
    그리고 a에는 setaddr(address B)라는 함수가 있는데 이게 어떤 함수냐면 : delegate call을 쓸때 앞에 있는 컨트랙주소를 변경한다.
    즉 그러니까 .스마트컨트랙B 주소를 넣어주는것이다.
    그럼 서로 연결이 되고, 그러면 A는 B의 적립포인트함수를 사용할수 있따.
    이것의 이점은 우리는 우선 고객들과 a간의 주소를 그대로 쓸 수 있따.
    그럼 데이터 이전도 마이그레이션도 필요가 없다.
    우리는 이것을 "upgragable 패턴이라고 부른다."

    예제를 통해서 알아보자.

*/
contract add{
    uint256 public num = 0;
    event info(address addr, uint256 num);
    function plus() public {
        ++num;
        emit info(msg.sender, num); 
    }
}
contract caller{
    /*여기엔 num이라는 변수가 있고
    call넘
    딜리게이트 컬이있다.
    여기 컬나우는 해당 스마트컨트랙의 함수를 불러서 plus를 불른다.
    그와반면에 delegate컬나우 함수는 delegatecall을 사용하여 plus를 사용한다.
    여기서 눈여겨 봐야할 것은ㄷ
    num의 변수가 각 스마트컨트랙내 서로 같다는 것이다.
    delegatecall을 사용할때 add의 스마트컨트랙 함수덕에 caller의 num이 바뀐다.

    반면에 일반 callNow함수를 호출한다면 add의 num 만 바뀐다.
    */
    uint256 public num = 0;
    function callNow(address contractAddr) public payable{
        (bool success, ) = contractAddr.call(abi.encodeWithSignature("plus()"));
        require(success,  "failed to transfer ether");
    }
    function delicateCallNow(address contractAddr) public payable {
        (bool success, ) = contractAddr.delegatecall(abi.encodeWithSignature("plus()"));
        require(success, "failed to transfer ether");
    }
}