// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.5.0 < 0.9.0; 
// 0.6 버전 이전의 fallback 함수 학습
/*
    fallback함수에 대해 학습
    fallback이라는 뜻은  : 대비책 이라는 뜻이다.
    따라서 fallback 함수는 대비책에 관련된 함수를 뜻한다.
    fallback의 특징은 :
    1. 먼저 무기명 함수이다. 즉 이름이 없는 함수이다.
    2. external 필수적으로 사용한다.
    3. payable을 반드시 사용해야한다.

    그렇다면 우리는 왜? fallback을 써야하는가?
    1. 스마트컨트랙이 이더를 받을 수 있게 한다.
    -> fallback 함수를 사용하므로써 스마트컨트랙이 이더를 받을 수 있도록 만드는 것이다.
    2. 스마트컨트랙이 이더를 받고 난 후 어떠한 행동을 취하게 할 수 있게한다.
    -> 예를들어 어떠한 스마트컨트랙에 20이더를 보냈을 때, 그럼, 스마트컨트랙 입장에서는 20 이더를 받자마자
    나에게 어떤 행동을 하게 될 것이다.(이더를 잘받았다 등) 어떻게 개발하냐에 따라 fallback함에 내용에 따라 달라진다.
    3. call 함수로 없는 함수가 불려질 때, 어떠한 행동을 취하게 할 수 있다.
    -> 지난 강의에서 배운 call은 이더만 받는 것을 배웠지만, 그러나 call 에는 한 가지 기능이 더 있는데, 
    외부 스마트컨트랙의 함수를 부르는 것이다. 예를 들어서 우리가 call 을 불러서 외부 스마트컨트랙의 함수 A를 불렀다고 가정했을때,
    그 외부 스마트컨트랙에는 함수 A가 없다. 그럴경우. 외부 스마트컨트랙에 있는 fallback 함수가 작동해서 함수A가 없다는 
    에러를 내거나, 대처를 하게 만든다. 
    이 3번같은 경우 예제를 통해 다시 확인해보자.

    따라서 이 fallback 함수의 경우 0.6버전 전후로 나뉘게 된다.
    0.6 이전의 fallback 함수는
    function () external payable {}
    그냥 function()을 써주시고 무기명 함수니까 이름이 없다. 그리고 external과 payable을 붙여준것을 볼 수 있다.
    이 payable을 붙여주는 이유는 fallback가 스마트컨트랙에게 이더를 받을 수 있는 기능을 부여해주기 때문에
    당연히 payable을 붙여주는 것이고, external을 붙이는 이유는 외부에서 이더를 보내기 때문에 당연히 external이 되어야 한다.

    0.6 이후에서는 fallback함수는
    fallback 은 recevie와 fallback으로 두가지 형태로 나뉘게 되었다.

    receive는 순수하게 이더만 받을 때 작동한다.
    -> 만약 20이더를 보내면 0.6이전에서는 fallback함수안에서 행동을 취했었는데, receive에서 행동을 취하게 된다.
    그리고 그 외의 경우 (call함수가 없는 함수가 불려질때라던가. 등) 에는 fallback 함수를 사용한다.
    fallback : 함수를 실행하면서 이더를 보낼때, 불려진 함수가 없을 때 작동한다.

    이 함수를 사용해서 이더를 보내질 때는 call함수를 사용한다면 이더도 보낼수 있고  함수도 부를 수 있게된다.
    그래서 이 call함수로 기능을 한번에 할 경우 fallback 함수가 작동하는 것을 알 수 가있다.

    *receive는 call함수로 이더만 보낼때*
    
    그럼 fallback의 기본형은 어떻게 되는가?
    기본형 : 불려진 항숨가 특정 스마트컨트랙이 없을떄 fallback 함수가 발동 한다.
    fallback() external {} 
    그리고 이 fallback같은 경우 payable을 안쓰고 있다. 왜냐하면 해당 기능을  receive()에서 해당 기능을 해주고 있기때문이다.
    그렇다면 해당 receive함수는
    receive() external payable{}
    처럼 사용하게된다.
    그러면 함수가 실행하면서 이더를 보낼 때, 즉 함수가 불러지면서 이더도 보내질때는
    fallback() external payable{}
    이렇게 작성하면 보낼수도 있게된다.
    그렇다면 우린 예제를 통해서 0.6버전 이전의 fallback함수부터 학습해보자.
*/
contract Bank{
    event justFallBackWithFunds(address addrs,uint256 val, string message);
    function() external payable {
        emit justFallBackWithFunds(msg.sender, msg.value, "justFallBackWithFunds is calles");
    }
    /*
        여기 Bank 스마트컨트랙트가 있다.
        Bank안에는 fallback 함수가 있다. = 무기명 함수
        그래서 덕분에 Bank는 이더를 받을 수 있게 되었다.
        따라서 그 함수에는 fallback함가 이더를 받으니 payable이 있어야한다.
        그리고 fallback함수에 external 이 있는것은 이 이더가 외부에서 들어오기 때문에 당연히 있어야한다.
        그리고 이더를 받고나서 fallback함수가 취하는 액션은 이벤트가 실행이된다.
        이 이벤트는 msg.sender 즉 누가 이더를 보냈는지, 
        msg.value 즉 얼마만큼의 이더를 보냈는지
        그리고 이벤트문구가 출력이 되는것을 알 수있다.
    */
}
contract You{
    //receive()
    /*
        여기 5가의 함수가 있다. 이 5가지 함수들은 유사하다.
        맨처음 함수는  to 라는 파라미터를 받는다. 당연히 이 것은 payable가 붙는다. 왜냐하면 우린 bank에게 이더를 보낼 함수기때문이다.
        그래서 이 함수자체에도 payable 이 있어야한다.
        그래서 이함수를 보자면 send 를 이용해서 Bank에게 보낼수가 있다.
    */
    function depositWithSend(address payable to) public payable{
        bool success = to.send(msg.value);
        require(success,"failled");
    }
    /*
        두 번째는 transfer를 통하여 이 Bank로 이더를 보내는 것을 알 수 있다.
    */
    function depositWithTransfer(address payable to) public payable{
        to.transfer(msg.value);
    }
    /*
        세 번째 함수는 call을 이용해서 Bank에게 이더를 보내는데,
        call같은 경우 0.7 전으로 이 쓰임새가 달라지기 때문에 우린 0.7버전 이전의 call 사용방식으로 써야한다.
        왜냐하면 우리가 확인하는 fallback함수는 0.6버전 이전의 버전이기때문에다.
    */
    function depositWithCall(address payable to) public payable{
        (bool sent, ) = to.call.value(msg.value)("");
        require(sent, "Falied to send either");
    }
    /*
        아래의 함수는 이것으로 이더를 보내는 것이 아니라 payable이 없어도된다.
        그리고 여기에 있는 함수를 실행시키고자 한다.
        사실 여기 call은 이더만 보내는 것이 아니라 함수를 보내는 기능이있다.
        이 기능에 대해서 다음시간에 알아보자.
        그래서 우선 to.call이렇게 써주고, "Hi"라는 함수를 부르려고 한다.
        사실 "Hi"라는 함수를 부를때 이렇게 부르는것이 아니고 다르게 불러야한다.
        그러나 우리는 편의상 값만 넣어주었다. 그래서 Bank 스마트컨트랙에선
        HI라는 함수가 없으므로 fallback에 걸리게 될것이다.
        따라서 fallback함수를 쓰는 이유중 세번째 이유인 함수가 없을때 발생한다는 것처럼
        Bank 스마트컨트랙에 Hi가 없으니 당연히 fallback에 걸리게된다.
    */
    function justGiveMessage(address to) public{
        (bool sent, ) = to.call("Hi");
        require(sent, "Falied to send either");
    }
    /*
        이 마지막 함수는 이더도 보내고 Hi라는 함수를 불른다. 
        그러니 얘도 동시에 fallback에 걸리게된다.
        이것을 확인해보기 위해 컴파일을 돌려보고 확인해 보자.
    */
    function justGiveMessageWithFunds(address payable to) public payable{
        (bool sent, ) = to.call.value(msg.value)("HI");
        require(sent, "Falied to send either");
    }
}
/*
    배포에 앞서 우선 
    Bank와 You를 모두 디플로이하고 
    Bank의 지갑주소를 복사하자.
    그래야 실습할 수 있다.
    1이더를 보내보자.
    이더와 이벤트가 모두 가 잘들어간것을 확인 할 수 있따.
    가장중요한점은은 msg.sender이다.balance;
    이 msg.sender같은 경우는 우리가 어카운트 1로 뱅크스마트컨트랙에 이더를 보냈는데
    이 msg.sender는 You라는 스마트컨트랙을 지칭하고 있따. 
    즉슨, 천천히 생각해보면 맨처음에 어카운트 1을 선택하고 1이더를 입력후 Bank 주소를 depositWithSend를 함수 실행을 하게되면
    You스마트컨트랙에서 함수를 실행하게 되면은 send라는 함수가 실행이되고
    우리가 보낼 1이더가 Bank로 들어간다.
    그런데 이 Bank입장에서 생각해보면 Bank는 이더를 You스마트컨트랙에서 받은 것이기 때문에
    msg.sender는 You가 되어야한다. 그래서 msg.sender는 이 스마트컨트랙을 실행하는 주체가 된다.
    즉 다시말하자면  You스마트컨트랙이 Bank라는 스마트컨트랙을 실행을 시켰다.
    그럼 이와 반대로 어카운트 1로 You스마트컨트랙에 디포짓위드센드라는 함수를 이용하였다. 
    You 스마트컨트랙입장에서는 msg.sender는 당연히 어카운트1이 된다.'

    그래서 다시 정리하자면, Bank의 msg.sender는 You가 되겠고, You의 msg.sender는 어카운트1이 되는것을 알수가 있다.
    그러면 이어서 두번째 함수고 실행해보겠다.
*/