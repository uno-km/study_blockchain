// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    먼저
    1. 주소.balance
    2. msg.sender()에 대해 학습
    
    [1] 첫번째로 balance는 
    주소.balance <- 이렇게 사용한다.
    주소.balance 는 해당 특정 주소의 현재 가지고 있는 이더의 잔액을 나타낸다.
    그리고 지난 수업에서 배운 msg.value는 우리가 이더를 보낼때 그 이더를 보내는 송금액이라는 차이가 있다.
    그러니까 이 msg.value와 주소.balance는 엄연히 다르니 헷갈리면 안된다.!!
    그래서 주소.balance 같은 경우는
    주소.balance 와 같은 형태로 사용한다.

    [2] 두번째로 msg.sender
    msg.sender는 스마트컨트랙을 사용하는 주체라고 생각하면된다.
    예를들어 엘리스라는 사람이 있는데
    이 엘리스는 어떤 스마트컨트랙의 함수를 사용한다고 가정하였을 때
    이 스마트 컨트랙 입장에서 엘리스는 msg.sender가 되는것이다.
    왜냐하면!! 이 엘리스는 이 스마트컨트랙을 " 사용 " 했기 때문이다. 
    따라서 엘리스는 msg.sender가 되는 것이다. 
    그리고 msg.sender같은 경우는 
    call 과 delegate call을 배울때 주요 키워드이니 msg.sender가 그만큼 중요하다 라는것을 인지하면된다.
*/
contract MobileBankIng{
    /*
        새로운 스마트컨트랙을 만들었다.
        그 스마트 컨트랙 안에는 3개의 이벤트 3개의 함수가 있다.
        각 이벤트들은 각 함수에서 사용하고 있는 것을 볼 수 있다.
        그럼 sendInfo는 msg.sender와 currentVal 를 출력하는 것을 알 수 있따.
        이것을 좀더 보자면 sendEither 함수안에는  to라는 이더를 받을 주소를 입력받고
        그래도 이더를 받아야 하기때문에 payable을 써야한다.

        그리고 함수 전부가 이더를 보내고 하는것이라 키워드  payable를 붙여주었다.
        그래서 이 이더는 transfer라를 함수를 통해 보내고 이더가 다 보내 졌을 때
        msg.sender와 msg.sender가 가지고 있는 금액이 나오게 하였다.balance;그럼 컴파일하고 실행해보자.

    */
    event sendInfo(address msgSender, uint256 currentVal);
    /*두번째 이벤트는 msg.sender와 또 그의 값을 출력한다. */
    event myCurrentVal(address msgSender, uint256 val);
    /*세번째 이벤트는 msg.sender와 주소 to, 그리고 값 val을 출력받는다.*/
    event currentValOfSomeone(address msgSender, address to, uint256 val);

    function sendEither(address payable to) public payable{
        require(msg.sender.balance >= msg.value, "Your balance is not enough");
        to.transfer(msg.value);
        emit sendInfo(msg.sender, (msg.sender).balance);
    }
    function checkValueNow() public {
        emit myCurrentVal(msg.sender, msg.sender.balance);
    }
    /*
        이 함수는 특정 주소의 balance를 확인하는 함수이다.
        당연히 여기는 송금하지않으니까 payable을 쓰지 않아따.
        그래서 이 이벤트트 보면 이 함수를 실행하는 사람이 들어가고, 
         currentValOfSomeone(msg.sender, to, to.balance) 를 보면
           msg.sender에는 이 함수를 실행하는 사람의 주소가 나오고
           to 같은 경우  balance를 체크할 사람의 주소가 들어간다.
           그리고 그 체크당하는 사람의 balance도  출력되는 이벤트를 호출한다.
           
    */
    function checkUserMoney(address to ) public{
        emit currentValOfSomeone(msg.sender, to, to.balance);
    }
}