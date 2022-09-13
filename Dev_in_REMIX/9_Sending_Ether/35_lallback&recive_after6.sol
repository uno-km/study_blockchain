// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.6.0 < 0.9.0; 
// 0.6 버전 이후의 fallback 함수 학습
/*
    0.6버전 이후의 fallback은 
    fallback과 receive 이렇게 2개로 나누어지는것을 알았다.
    그래서 이제 이 예제에서는 Bank에는 2개의 이벤트와 리시브와 fallback 함수 2개도 추가해주겠다.
*/
contract Bank{
    event justFallBack(address addrs, string message);
    event receiveFallback(address addrs,uint256 val, string message);
    //event receiveFallback(address addrs,uint256 val);
    event justFallbackWithFunds(address addrs,uint256 val, string message);
    fallback() external payable{
        emit justFallbackWithFunds(msg.sender,msg.value,"justFallbackWithFunds is called");
    }
    receive() external payable{
        emit receiveFallback(msg.sender, msg.value, "RecevieFallback is called");
        //emit receiveFallback(msg.sender, msg.value);
    }
    /*
        먼저 이 리시브펑션을 보자면, bank 스마트컨트랙은 리시브펑션을 통해서 이더를 받는 것을 알 수 있따.
        즉 그러니까 receive펑션에는 당연히 payable이 들어가야한다. 왜냐하면 receive함수를 통해 이 스마트컨트랙전체가 이더를 받으니까
        그리고 external이여한다. 외부에서 이더가 보내지기 때문이다.
        그래서 순수하게 이더만 보내졌을땐 receive함수를 통해서 이 스마트컨트랙이 이더를 받는 것을 알 수있따.
        그리고 이더를 받고 난후에 receiveFallback 이벤트가 실행되는것을 알수있따.
        receiveFallback 에는 누가보냈는지, 얼마를보냈는지, 그리고 메세지가 나온다.
        Fallback함수의 경우는 주로 함수를 실행하면서 이더를 보낼때, 동시에 할때, 또는 불러진 함수가 없을때 작동을한다.
        그래서 이와같은 경우 이더를 보내고 함수를 같이 실행할 때 당연히 payable을 써주어야한다.
        하지만 현재는 페이어블을 빼고 실험을 해보자.

    */
}
contract You{
    /*0.6버전 이후와 이전의 함수들은 크게 변한건 없으나, 함수안의 to.call 쪽이 조금 바뀌었다.*/
       function depositWithSend(address payable to) public payable{
        bool success = to.send(msg.value);
        require(success,"failled");
    }
    function depositWithTransfer(address payable to) public payable{
        to.transfer(msg.value);
    }
    function depositWithCall(address payable to) public payable{
        (bool sent, ) = to.call{value:msg.value}("");
        require(sent, "Falied to send either");
    }
    function justGiveMessage(address to) public{
        (bool sent, ) = to.call("Hi");
        require(sent, "Falied to send either");
    }
    function justGiveMessageWithFunds(address payable to) public payable{
        (bool sent, ) = to.call{value:msg.value}("HI");
        require(sent, "Falied to send either");
    }
}
/*
    마찬가지로 뱅크와 유를 모두 디플로이해보자.
    그리고 뱅크 지갑주소 복사해서 1이더를 보내면 오류가 뜨는것을 볼 수 있따.
    그리고 send, transfer 모두 오류가 난다.
    call을 통해서 해보자.
    잘보내진다.
    왜 오류가 나는 것일까?
    이것은 우리가 배운 32강의 send와 transfer처럼 가스 소비가 2300일때가 있다.
    그러나 call은 가변적인 가스를 소비한다.
    이스탄불 하드포크 이후 이 call을 사용하기 권장한다.
    즉 다시 정리해서 말자하면 
    우리가 쓰고있는 
    send와 transfer는 2300 가스를 써서 이 이벤트를 출력하는데 힘들어한다.
    그래서 우리는 이 string부분을 한번 수정해보고자한다.
    우선 주석처리를해서 스트링부분을 지우고
    다시 컴파일하고 배포해보자.
    그리고 다시 1이더를 보냈더니
    잘보내진것을 알 수 있따.
    우린 스트링만 지웠을 뿐인데 
    가스 소비량이 2300가스이상으로 가지않기때문에
    이런함수가 잘 작동한것으로 알 수 가 있다.
    그러면 당연히 다른 함수들도 다잘작동하는것을 알 수 있다.
    즉 이 함수들은 2300가스로 출력하기 힘들었다는 얘기이다.
    이 이벤트안에는 msg.sender, msg.value, 스트링 값이 있었는데, 
    이것들을 모두 출력하기엔 2300가스가 턱없이 부족했다는 것이다.
    그 외반에 이 call은 가스가 가변적이기 때문에, 당연히 제한이 없어서
    출력이 되는것이었다.

    그러나 또 신기하게도 0.7버전으로 컴파일해서 돌리면
    오류가 안나는고 잘작동하는 것을 확인 할 수 있다.
    0.7버전에서 0.8버전으로 가면서 가스의 가격이 올랐다.
    그렇기 때문에 sned,transfer을 이욯한다면 가스 소모량이 2300밖에 안되기 때문에
    이런식으로 에러가 나니까 call을 사용하라고 권장하고있는것이다.
    
    이제는 뱅크에 없는 함수를 불렀을땐 어떨까?
    잘작동한다.

*/