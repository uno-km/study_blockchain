// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    payable : 이더와 토큰을 상호작용시 필요한것, 
    쉽게 얘기하면 우리가 이더를 보내거나 받을 때 payable 이라는 키워드가 필요하다. 그래서 예를들어서
    이더를 보내는 함수를 만든다고 가정했을 때  그 함수에는 payable을 꼭 붙여주어야한다.
    그리고 payable은 주로 send, transfer, call 을 이용하여 , 이더를 보낼때 Payable이라는 키워드가 필요 하다.
    즉 이더를 보내는 3가지 함수들과 같이 사용된다.
    이 Payable은 주로 함수, 주소, 생성자에 붙여서 사용된다. 꼭 기억하자
    
    2. msg.value : 간단하게 송금보낸 코인의 값이라고 생각하면 된다.
    
    3. 마지막으로 이더리움을 보내는 3가지 함수에 대해 알아보자.
    이 3가지 함수는
        이것을 공부하기전 무서를 보면, solidity 초기 send라는 함수가 있었다고 한다.
        그 send라는 함수를 이용해서  이더를 보내곤 했는데,
        이 send의 특징이 정확히 "가스를 2300을 소비하고, 성공여부를 에러대신 true, false로 리턴했다."
        그래서 사람들이 생각하기엔 이 send에 단점이 error를 보내는 것을 못하는것 이라고 생각을 했다.
        그래서 2번쨰로 나온 녀석이 Call이다.
        call의 경우 send와 다르게 send와 다르게 가변적인 gas를 설정할 수 있다. 즉 가스를 지정할 수 있따.
        가스는 gas(500) 이런식으로 지정해서 사용할 수 있게 했다고 한다.
        그런데 이 call도 이 성곡여부를 true와 false로 리턴했다. 그리고 더 나아가서 이 call을 사용하므로써 사람들은
        이   re-entrancy attack을 발견하였다. - 즉 이 call을 사용하므로써 재 진입 공격에 취약하게 된것을 알게된다.
        더 나아가서 "재 진입 공격이란? : 한개의 스마트 컨트랙이 다른 스마트컨트랙에 이더를 보낸다고 했을떄 , 이 이더를 보내는과정이
        계속 가스를 다 소비할 떄까지 무한 반복하는 것" 이다.
        근데 이 call의 경우는 가스가 가변적이기 때문에 재진입 공격에 굉장히 취약해진다. 
        그와 반대로 send의 경우는 가스를 2300 밖에 소비를 안하니까 재진입공격에서 좀더 안전하다.
        그래서 사람들은 0.4.13 버전 이후로 이 transfer()이라는 함수를 만들게 된다. 
        이 transfer의 경우는 가변적인 가스가 아니라 2300가스를 소비하고, 실패시 에러를 발생하게 된다.
        그래서 정리해서 말하자면,
        [1] send    : 2300 가스 소비, 성공여부를 에러가아닌 true/false로 리턴
        [2] transfer: 2300 가스를 소비, 실패시 error를 발생 
        [3] call    : 가변적인 가스를 소비하고, 성곡여부를 true/false로 리턴 + 재진입(re-entrancy)공격 위험성 있음, 2019년 12월 이후 call 사용 추천
                      - 즉 transfer이 좀더 안전하다. 그래서 사람들은 이 transfer를 사용하라고 더 권장한다.
        ** 그러나 2019년 12월 이후 "이스탄불 하드포크"가 일어나면서 , 오퍼레이션코드의 가격이 오른다. 
        즉 가스의 가격이 올랐다. = 이말은 send와 transfer같은 경우는 가스의 양이 2300 밖에 소비를 안한다.
        그런데 이 2300이 스마트컨트랙을 이용할땐 부족할 수 있다. -> 예를들어서 operation 코드를 사용하는데 가스의 양이
        5000이라고 하였을 때, transfer와 send로 이용해서 스마트컨트랙을 만들기엔 턱없이 부족한다.
        그렇기 떄문에 사람들은 이스탄불 하드포크 이후 call을 더 사용하기를 권장한다.

        그럼!! call은 재진입공격에 취약한다. 어떻게 사용해야할까?
         이 solidity 문서를 보면
         Check-Effects-Interections Pattern이 있는데, 

        contract Fund{
            ///Mapping of ether shares of the contract.
            mapping(address => uint) shares;
            ///Withdraw your share.
            function withdraw() public {
                var share = shares[msg.sender];
                shares[msg.sender] = 0;
                msg.sender.transfer(share);
            }
        }
        이런식으로 사용한다. 그리고 더 나아가서 
        call같은 경우는 gas의 양을 지정할 수 있는데
        이스탄불 하드포크 이후 가스의 가격이 더 오를 수 있기 때문에
        우리가 가스의가격을 지정해 주지 않는게 좋다.
        그러면 우리가 예제를 통해 확인해보자.
        먼저  send와 transfer에 대한 함수를 만들어보자.
*/
contract sendEther{
    event howMuch(uint256 val);
    /*우선 이 sendNow라는 함수를 보자면 이 to라는 주소는 이더를 받을 사람이다. 
    즉 받을 사람의 주소이다. 그래서 이더와 상호작용한 키워드가 patable이 필요하다.
    그리고 이 함수 전체적으로 우리가 이더를 그 to에게 보내는 것이까.
    payalbe이 또 뒤에 필요한 것이다.
    snedNow를 보자면 안에 send라는 함수가 있는데, 이 send라는 함수는 이더를 보낼사람, 그리고 " . "을 붙여주고 
    send를 붙인다음 msg.value를 써준다. 
    이 msg.value는 우리가 송금보낸 코인의 값이라는 것인다. 배포할때 우리가 Gas Limit에 써가지고 이더를 보낸다.
    그때 우리가 입력한 VALUE에 값이 들어간다. 그래서 이 send같은경우 true/false라고 나타난다고 한다.
    만약 이 성공여부 리턴에 대해 true가 나오면 sent는 true가 되며, true면 require값에 걸리지 않고 통과한뒤 이벤트를 출력하게된다.
    만약에 이 함수가 false를 낸다면 require에 걸리고, 해당 메시지가 나온다.
    */
    function sendNow(address payable to) public payable{
        bool sent = to.send(msg.value);
        require(sent,"Failed to send either");
        emit howMuch(msg.value);
    }
    /*
        두번째의 transferNow는 마찬가지로 송금을 받을사람의 주소가 필요하다.
        송금받을 사람의 주소에도 payable를 써주고 또 이 함수자체도 이더를 이용하니까 payable을 사용한다.
        여기는 윗 함수처럼 require를 써주지 않고 to.transfer로 간단하게 써줄수 있따.
        왜냐하면. transfer자체 내에 에러를 간단하게 써줄수 있기 떄문이다.
        그래서 이 send의 경우는 true/false를 리턴하니까 안에서 잘돌아가는지 안돌아가는지 에러를 체크를 해줘야하는데
        transfer의 경우 바로 에러를 내보내니까 에러를 체크할 필요가 없어진다.
        그래서 이것이 실패를하면 해당 에러에서 걸려서 이벤트가 나오지 않을 것이다.
        만약 성곡하면 이벤트로 넘거갈것이다.그리고 이벤트에서는 msg.value가 나오는 것을 알수가 있다.
        이제 해당 함수들을 실행해보자.
    */
    function transferNow(address payable  to) public payable {
        to.transfer(msg.value);
        emit howMuch(msg.value);
    }
    /*
        배포를 해보면 원래 기존에 하늘색, 주황색 버튼이 아니고 
        빨강색버튼을 볼수 있다. 이 빨강색인 이유는 payable을 붙여주어서 그렇다.
        우린지금 첫번째 어카운트인데 두번쨰 어카운트에 이더를 보내보도록 하곘다.
        -- 상단에 ACCOUNT(+)여기서 두번째 셀렉트를 하고 복사

        첫번째에는 10이더를 보냈다.
        그리고 해당 함수를보니까 10의 19승 웨이가 나온것을 볼 수 있다.

        두번째의 트랜스퍼 나우 함수도 실행해보면
        정상적으로 나간걸 볼 수 있따. 10의 19승 웨이가 있다.
    */
    /*
        이제 세번째로 call에 대해서 학습해보자.
        우리는 callNow라는 함수를 만들었다.
        즉 이 파라미터, 이더를 받을 사람의 주소가 필요하고, 당연히 파라미터에도 payble이 붙어야하고,
        이 함수가 이더를 보내는것이기에도 함수에도 payable이 필요하다.
        call같은 경우 0.7 버전 이후로 쓰임새가 변하게 되는데,
        0.7 이전에는, 
        (bool sent, ) = to.call.gas(1000).value(msg.value)("");
        require(sent, "failed to send either");
        이렇게 쓰였다.
        그래서 이 call을 자세히 보자면
        to라는 보낼사람의 주소를 붙여주고, " . "을 붙여준뒤 call을 써주고 그리고 중괄호를 열어주고, 
        그다음 msg.value , 그리고 가스를 얼마만큼 보낼지 지정해서 보내준다. 그런데 이스탄불 하드포크 이후 가스를 지정해주지 않는 것 좋다.
        왜냐면, 미래적으로 가스의 가격이 더 오를 수 있기 때문에 이 스마트 컨트랙이 잘 작동 하지 않을 수도 있어서 이다.
        그래서 이 call 도 마찬가지로 리턴을 true와 false로 변환한다.
        그래서 이것이 성공을 한다면, true를 리턴하고 , 
        send와 마찬가지로 require를 이용해서 잘작동하는지 확인하면된다.
        일단 우린 0.7 이후 버전이후의 call을 사용해보자.
    */
    function callNow(address payable to) public payable{
        (bool sent, ) = to.call{value: msg.value , gas:1000}("");
        require(sent, "Faild to send Ether");
        emit howMuch(msg.value);
    }
    /*
        그리고 해당 주소로 계속보내고 그러면 대상 주소가 빵빵해지는것을 볼 수 있따.
    */
}