// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    에러핸들러에 대해 공부 :
    지난 번에 학습(25강)간 배웠던 3가지의 에러핸들러는 0.7이하버전이었다.
    이번엔 0.8 버전에 대해서는 어떻게 사용하는지 알아보자.
    1. require
    2. revert
    3. assert
    솔리디티 다큐멘테이션에 의하면 assert는 
    "오직 내부적 에러 테스트 용도, 불변성 체크 용도"
    그리고 assert가 에러를 발생시키면 Panic(uint256) 에러 타입의 에러를 발생시킨다.
    이건 try/catch 사용된다.
    이 Panic()은 0.8.0 에는 없으며
    0.8.1~ 이상부터 있다.
    그래서 우리는 0.8.1 버전이상으로 컴파일해서 사용해보자
*/
contract ErrorHandler{
    //그래서 우리는 0.7버전과 0.8.1 버전을 비교해서 컴파일 해보기로한다.
    function assertHandler() public pure{
        assert(false);
    }
    function revertHandler() public pure{
        revert("revert!");
    }
    function requireHandler()public pure{
        require(false,"occurred");
    }
    /*
        0.7~버전이하에서는 assert함수를 사용하면 가스 환불을 받지 않았지만
        0.8.1이상버전에서는 assert함수를 사용하면 가스를 환불받는다.
        그리고 에러도 revert 에러로 처리된것을 알 수 있다.
        다시말하면
        "어설트"는 가스를 환불 받을 수 있다고 볼 수 있다.
        0.8.1 오직 내부적 에러가 났을때 패닉을발생시킨다고 하는데
        솔리디티에서 정의하는 에러가 무엇인지 보자.
        솔리디티에서는 10가지 특정에러를 정의하고있다.
        그중 5를 0으로 나누었을때, 
        배열의 순번이없을때,
        등등등 이 assert에러로 처리가되며, 이때 Panic타입의 에러를 발생시킨다고 한다. 
    */
}