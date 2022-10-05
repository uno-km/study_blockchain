// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0; 
/*
    거의마지막이다.
    기본적인 솔리디티 개념을 알고있어도 막상 스마트컨트랙을 만드려고 하면, 약간 어려울것같아서
    한번 작성해 보았다.
    우선은 3의배수번째의 사람에게 이더주는 스마트컨트랙을 만들어보겠다.
*/
/*
    설계 : Money Box라는 스마트컨트랙을 만들고 해당 컨트랙트는 3의 배수번째로 요청한 사람에게 이더리움을 주는 방식이다.
    첫번째 사람이 MoneyBox에 요청을 한다. 첫번째사람이니 이더를 안준다.
    두번째 사람이 또 요청을 한다. moneybox에서는 다시 순서를 계산하고 3이 아니니 주지않는다.
    서번째 사람이다. 머니박스에서 3의 배수인것을 계산하고 참값이 나왔으므로 이더리움을 주게된다.
    그리고 머니박스의 밸런스는 줄어들게된다.
*/
contract MneyBox
{
    /*
    *규칙*
    - 우선은 1이더만 주어야한다. 
    - 딱한번밖에 줄수없으며 한번만 참여 가능하다. ( 단, 누군가가 적립금을 받으면 초기화)
        > 중복불가능인 이유 : 만약 누군가가 고의적으로 1이더를 받기위해 3의배수번째가 되기 시도하는걸 막기위해서다.
        > 그대신 누군가 적립금을 받으면 중복했던 기록들이 초기화가 된다.
    - 관리자만 적립된 이더를 볼 수 있다.
        > 만약 일반사람들이 본다고 하면, 3의 배수번쨰인지 아닌지 유추가 가능한것을 막기위함이다.
    - 3의 배수 사람에게만 적립 이더를 준다.
    */
    /*이 이벤트 whoPaid는 머니박스의 돈을 주는사람과 얼마를 내는지를 이벤트 출력을 한다.*/
    event whoPaid(address indexed sender, uint256 payment);
    // 머니박스의 배포자, 즉 오너를 나타낸다.
    address owner;
    /*
        두번쪠 조건을 위해서 만든 매핑이다. 즉 어느 유저가 머니박스에게 1이더를 주면 paidMemberList에 기록이 되어서 
        다음에는 중복참여가 불가능하도록 만든 장치이다.
        그래서 이 매핑을 자세히 보자면, 현재 키(uin256)와 밸류(mapping(address => bool))가 들어간다.
        그리고 그와중에 밸류도 매핑이여서 address와 bool이 키밸류로 저장된다.
        이렇게 작성한 이유는 
        mapping(address => bool) paidMemberList2 라고 사용자가 만들어서 주소와 bool값만 매핑을 한다면
        중복참여를 막기위해서 bool값을 참으로 만듭니다. 만약 a가 1이더를 주고나서 또 머니박스에 1이더를 준다면
        이 머니 박스는 매핑을 이용해서 체크를 할것이다.
        그래서 address안에 해당 주소를 넣고 트루인지 펄스인지에 따라서 1이더를 받을지 안받을지 결정한다.
        근데 a유저는 이미 1이더를 냈으면 true가 되었으니까. 당연히 머니박스는 거절을 하게될것이다.
        그리고 uint256으로 한번더 감싼이유는
        a,b,c가 이더를 넣고 뽑았을때 만약 c가 당첨이 된다면 paidMemberList2는 초기화가 되어야한다.
        그런데 초기화를 시키려면 mapping에는 완전히 모든것을 삭제하는 것이 없기때문에
        우리가 하나하나 false로 바꾸어야한다. 따라서 우리는 각 주소를 알아야한다.
        왜냐하면 우리는 a라는 key값을 넣고 bool값을 true-> false로 바꾸어주어야한다. 총
        3번을 바꿔줘야한다.
        그러기위해 a,b,c의 주소를 address로 또 다른 변수에 값을 저장하고 그러면 가스낭비 메모리낭비가 심해질것이다.
        그렇지 떄문에 우리는 uin256로 한번 더 감쌌다.
        paidmemberList를 보면 현재 uin256를 키로 만들었다. 그래서 uin256을 키로, 그것은 round로 나타낸다.
        이 머니박스에는 1라운드, 2라운드, 3라운드 4라운드 등등 여러개가 존재할 수 있따.
        따라서 uint256은 round라고 생각하면 된다.
        쉽게 설명하면 
        money박스의 로직을 게임으로 비유할수있게된다. 머니박스라는 게임은 3의 배수번째 사람에게만 이더를 주는 게임이다.
        이말은 즉슨, 3의 배수번째인 사람이 이더를 내면 그 게임이 끝나고 다음라운드로 넘어가는 것이다.
        예를 들어서 
        1라운드에서는 ABC 이렇게 순서대로 게임참여했더니 승자는 C가 될것이고 적립된 이더를 받게될것이다.
        그리고 2라운드로 넘어가고 또 거기서 ERD 라는 사람이 이더를 주고 참여하면 또 E는 이더를 받는다.
        등등등
        그래서 각 라운드마다 paidmemberList 가 존재하는것이다.
        따라서 A라는 사람이 1라운드에 참여를 했어도, 2라운드, 3라운드에도 참석이 가능하게 되는것이다.
    */
    mapping (uint256 => mapping(address => bool)) paidmemberList;
    uint256 round =1;
    //그래서 이 생성자를 보면 오너가 배포될때 대입이 되는것을 볼 수 있따. 즉 msg.sender는 머니박스의 배포자이다.
    constructor()
    {
        owner = msg.sender;
    }
    receive() external payable
    {
        require(msg.value == 1 ether, "Must be 1 ether.");
        require(paidmemberList[round][msg.sender]==false,"Must be a new player in each game.");
        emit whoPaid(msg.sender,msg.value);
        if(address(this).balance == 3 ether)
        {
            (bool sent, ) = payable(msg.sender).call
            {
                value:address(this).balance
            }("");
            require(sent, "Faided to pay");
            round++;
        }
    }
    function checkRound() public view returns(uint256)
    {
        return round;
    }

    function checkValue() public view returns(uint256)
    {
        require(owner==msg.sender,"Only Onwer can check the value");
        return address(this).balance;
    }
}
