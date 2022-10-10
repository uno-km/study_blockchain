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
        죽 "주소" 라는 키값이 있고, 불린타입의 밸류값이 있다.

        만약에 uint256에 1라운드를 매핑을 해놓고 A라는 주소를 넣으면, true가 된다. B도, C도 다 true가 될것이다.
        만약 우리가 2라는 키를 넣는다면 당연히 다른 페이드 멤버리스트의 밸류값을 반환하게 된다.
        왜냐하면 ABC가 트루일때 2라운드 키값 2에서는 ERD만 트루가 될것이다. ABC는 false란 얘기이다.
        더 나아가서 키값 3을 넣는다고 하면은 ARB만 트루가 될것이다.
        즉 이렇게 라운드마다 다르니까. 참여한 사람들의 주소들을 따로 저장을 한다음에 이 게임이 끝나고 다 false로 바꿔줄 필요가 없다.
        새로시작한다.
        그래서 3라운드의 B라는 사람을 통해서 끝나게 된다면 4라운드에서 모든유저는 다 false가 되어있을 것이다.
        그래서 우리는 키값 - 라운드를 넣어주고 각사람들의 주소, 그리고 true인지 false인지 보고 paidMemberList에 기록이 되는지 알수있따.

        그래서 우리는 round라는 변수가 정의되어있고, checkRound를 보면 모든사람들이 현재 이게임이 몇게임인지 알 수있다.


    */
    mapping (uint256 => mapping(address => bool)) paidmemberList;
    uint256 round =1;
    //그래서 이 생성자를 보면 오너가 배포될때 대입이 되는것을 볼 수 있따. 즉 msg.sender는 머니박스의 배포자이다.
    constructor()
    {
        owner = msg.sender;
    }
    /*
        falback함수를 보면
        receive는 payable인것을 알 수 있다.
        만약 우리가 A라는 유저가 스마트컨트랙에 1이더를 보낸다고 한다면
        receive 폴백함수가 돌면서 이 require가 작동을 할 것이다. 당연히 이 msg.value은 1이더여야 한다.
        왜냐하면 우리의 특징은 1이더만 내는 것이기 떄문이다.
        그리고 2번쨰 조건은 이 중복참여인데,  paidmemberList[round]의 round라는 키값을 넣어주고
        그다음에 key값은 어드레스값 : msg.sender (리시브에게 돈을 준사람)이 돈을 안주었으니 false여야지 
        스마트컨트랙을 처음 1개 이더를 주는 사람이여야지 기록하게된다.
        그래서 paidmemberList[round][msg.sender] = true로 변환하게 된다.
        그리고 나서 이벤트가 출력하게 된다. - 이어서 계속
    */
    receive() external payable
    {
        require(msg.value == 1 ether, "Must be 1 ether.");
        require(paidmemberList[round][msg.sender]==false,"Must be a new player in each game.");

        paidmemberList[round][msg.sender]=true;

        emit whoPaid(msg.sender,msg.value);
        /*
            여기에서 이 스마트컨트랙에 balance를 체크를 한다.그래서 스마트컨트랙의 밸런스를 체크하게 되는데
            3이더는 call함수를 이용해서 스마트컨트랙이 가지고 있는 모든 이더를 해당 주소로 전달하는것을 알 수 있다.
            이 말은 즉슨 3번째 사람인것을 알 수 가있다.
            왜냐하면 한사람당 1이더를 주니까. 적립된 금액이 3이더가 된다면 그사람이 3번째 사람이기 때문이다.
            그 3번째 사람에게 스마트컨트랙이 가지고 있는 모든 이더를 돌려주는 것을 알 수 이따.
            그래서 msg.sender 가 될것이다.
        */
        if(address(this).balance == 3 ether)
        {
            (bool sent, ) = payable/*이더가 오고가니 payable이 맞다.*/(msg.sender/*3번째로 스마트컨트랙에 돈을 준사람*/).call
            {
                value:address(this).balance
            }("");
            require(sent, "Faided to pay");
            /*이렇게 실패가 없이 보내지게 된다면 round가 올라간다.*/
            round++;
        }
    }
    function checkRound() public view returns(uint256)
    {
        return round;
    }
/*
    여기 checkValue()를 보면, owner만, 즉 스마트 컨트랙을 배포한 사람만 이 함수를 이용 할수있다.
    만약 스마트컨트랙 배포자가 이 컨트랙의 밸런스, 적립된 이더를 본다고 한다면, 이렇게 해주어야 한다.
*/
    function checkValue() public view returns(uint256)
    {
        require(owner==msg.sender,"Only Onwer can check the value");
        /*
            여기의 this는 스마트 컨트랙을 나타내는 것이고, balance를 보기위해서 스마트컨트랙을 주소화 해주어야 한다.
            그래서 return(this) 를 통해 주소화를 하고 리턴을 시켜준다. 
            그리고 balance를 통해 이 스마트 컨트랙이 얼마가 들었는지 알 수 있따.
            즉 배포자만 이 스마트컨트랙의 잔액을 볼 수 있따.
        */
        return address(this).balance;
    }
}
/*
    이후로는 메타마스크 연동을 통해 학습해보도록 해보자.
*/
