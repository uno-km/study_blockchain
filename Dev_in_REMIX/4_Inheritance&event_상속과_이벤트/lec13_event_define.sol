// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    이벤트에대해 학습 :
    첫강의에서 언급했듯이  솔리디티 안에서는 프린트, 콘솔로그 등이 없다.
    그대신 이벤트를 통해서 값을 출력 할 수 있다.
    좀 더자세히 보자면, "이벤트"로 값을 출력할 때, 그 값들을 블록안에 저장이 된다.
    블록안에 저장이 된 것은 우리는 언제든 꺼내서 쓸수 있다.
    그러면 이벤트를 어떻게 정의하는 것일까?

*/
 contract eventEx1{
        event info(string name, uint256 money); //먼저 이벤트를 정의하기 위해서는 event라는 키워드를 먼저써준다.
                                                //그리고 이벤트명, 그리고 이벤트 내에 우리가 출력하고 싶은 값들을 써준다.
                                                // 우리는 지금 string name, uint256 money  이렇게 2개의 값을 출력하려고 한다.
                                                //그럼 저 info를 어떻게 출력할까?
        function sendMoney() public { //함수하나를 선언하자, 그리고 만약 샌드 머니라는 함수를 사용한다면 누가 보냈는지 에대한 기록이 필요하다.
            emit info("KimUno",12000); //그래서 인포값에  보내는 사람의 이름과 금액을 지금 출력하려고 한다. <- 이값들을 출력하게 되면 블록체인 안에 블록에 저장이된다.
                                        //이 블록이 저장되게 되면은 우리는 언제든지 꺼내서 사용할 수 있다.
        }

 }
 /*
    컴파일을하고 배포를 하고 sendMoney를 눌러보면
    log안에 우리의이번트인 info, 그리고 그안에 값에 이름과 금액이 들어있다.
    즉 이 이벤트가 이 블록안에 각인이 되었다는 것을 알 수 있다.
    그러니까 우리는 언제든지 info의 값들을 가져와서 사용할 수 있다.
 */