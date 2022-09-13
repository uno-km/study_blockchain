// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    payable을 생성자에 넣을떄와 특정 주소에 권한을 주는 방법에 대해 학습해보겠다.
    먼저 여기서 사용할 예제는 지난 강의 33강의 예제를 가져와서 사용하겠다.
    그리고 우리가 32강에서 payable을 처음 사용했는데 이 payable 같은 경우는
    주로 함수, 주소, 생성자에 붙여서 사용된다.
    그래서 32강을 보면 우린 현재 주소에 payable도 넣어보기도 하고, 또 함수에 payable을 넣어보기도했다.
    아직 생성자에 넣어보지 않아서 그 부분에 대해서 학습해보자.
*/
contract MobileBanking{
    /*
        우선 생성자(constructor)를 생성하였다. 
        그리고 해당 생성자에 payable을 붙여놓았다.
        그러면 이것을 하나씩 뜯어보자.
        이 생성자는 스마트컨트랙이 배포될 때 제일 먼저 실행되는 것이다.
        그런ㄷㅔ 또 이 payable의 경우는 이더를 전송하거나 받을때 필요한 키워드이다.
        이말은 즉슨 이 스마트컨트랙이 처음 배포될때 이 payalbe 키워드를 만난다는 것인데
        이 스마트컨트랙이 처음 배포될 때 이더를 받게 될 수 있다는 것이다.
        그래서 이 배포를 할때 스마트 컨트랙의 생성자에 이더를 넣어보도록 해보자.

        지금 배포하는 곳을 보면 DEPLAY가 빨강색으로 바뀌어있는 것을 볼 수 있따.
        이것은 생성자에 payable이 붙어있어서 그텋다.
        이말은 즉슨 배포를 할 때 이더를 받을 수 있다는 얘기이다.
    */
    address owner;
    constructor() payable{
        owner = msg.sender;
    }
    
    function sendEither(address payable to) public payable{
        require(msg.sender==owner, "Only Owner");
        require(msg.sender.balance >= msg.value, "Your balance is not enough");
        to.transfer(msg.value);
        emit sendInfo(msg.sender, (msg.sender).balance);
    }
    /*
        우리가 배포를 할때 우리가 배포를 했던 주소를 owner에 넣는다는 얘기이다.balance;
        그리고 owner의 타입은 address가 되는 것이다.
        그리고 이 sendEther라는 함수안에는 require라는 함수가 있는데 
        이 msg.sender 가 꼭 owner여야지 사용할 수 있게 한다. 
        만약 이 msg.sender가 owner와 같지 않다면  에러를 발생한다.
        그말은 즉슨 onwer만 이 함수를 사용할 수 있따.
    */
    /*
        그리고 우리가 지금 require을 써가지고 특정 권한을 주었는데, 
        이것을 modifier로 변경할 수 있따.
        그리고 공통적으로 사요ㅕㅇ할 수 있게 해보자.
    */
    modifier onlyOwner{
        require(msg.sender==owner, "Only Owner");
        _;
    }

    event sendInfo(address msgSender, uint256 currentVal);
    event myCurrentVal(address msgSender, uint256 val);
    event currentValOfSomeone(address msgSender, address to, uint256 val);

    function checkValueNow() public onlyOwner {
        emit myCurrentVal(msg.sender, msg.sender.balance);
    }
    function checkUserMoney(address to ) public onlyOwner{
        emit currentValOfSomeone(msg.sender, to, to.balance);
    }
    /*
        public뒤에 modifier로 만든 onlyOwner를 각 함수에 다 넣어보고
        배포하고 실행하여 각 지갑의 주소로 테스트를 진행해보자.
    */
}