// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    루프, 즉 반복문에 대해서 학습
    * for, while, do-wile 총 3가지가 있다.
    먼저 반복문은 어떤 특정한 행위를 반복시켜주는 것이다.
    예를들면 1부터 100까지 출력을 하고싶을때 , 반복문을 사용한다면 쉽게 실행시키는 코드를 짤수 있다.
    1. for는 :우선 for을 써주고 
    for(초기값 , loop최대치 , forLoop가 돌때마다 변화값;){
        내용
    } 
    이렇게 작성한다.예제를 통해서 학습해보자.
*/
contract loop{
    event cnttIdxNm(uint256 indexed idx, string name);
    string[] private cntList = ["Korea,","Jappan","China","U.S.A."];
    function forLoopEvent() public {
        for(uint256 i = 0 ; i < cntList.length ; i++){
            emit cnttIdxNm(i, cntList[i]);
        }
    }
    /*
        여기 배열은 우선 총 4개의 나라가 있습니다.
        우리는 위 반복문을 통해서 쭉 출력시키고자 합니다.
        그리고 생성한 cntIdxNm은 배열의 인덱스와, 그 인덱스에 해당하는 나라이름을 출력합니다.
        그래서 이 for-loop 반복문을 생성했습니다.
        그리고 forloop문들 보면 uint256 i 를 0부터 시작하게 해주었는데,
        보통 배열은 0부터 인덱싱이 시작되어서 i(index의  줄임)도 0으로 선언하고 시작한다.
        for-loop가 무한정 돌게 할 수 없으니, 최대값을 정해주는 부분이 가운데 이다.
        따라서 지금은 cntList의 길이 즉 4가 된다.
        그리고 for문 한번 돌면 i값을 이제 카운팅해주는 부분은 for-loop문의  맨뒤 i++부분이 실행한다.
    */    
    //2. while 루프
    /*
        while루프는 for루프와 큰차이가 없다.
        while루프를 써줄때 초기값을 밖에 써준다.
        그리고 while() 의 괄호안에 얼마나 돌아야하는지 써준다.
        그리고 내부에는 내용을 써준다.
        while루프도 간단하게 보자
    */
    function whileLoopEvent() public {
        uint256 i = 0;
        while(i<cntList.length){
            emit cnttIdxNm(i,cntList[i]);
            i++;
        }
    }
    /*
        while 루프도 for루프랑 굉장히 같다. 차이점은 i++을 밖에 두었냐 안에 두었냐 정도이다.
        그리고 초기값도 초기값을 밖에서해주느냐 이다.
        초기값 = i;
        그러다 while()괄호안이 true, false 에 따라 계속 돌지 안돌지를 논리연산을 통해 반복유무를 판단하고
        조건이 만족하지 않을때 (false가 되었을때)까지 반복을 시킨다.
        그게아니면 무한반복을 하게된다.
    */
    //3. do while
    /*
        while과 굉장히 유사하다.초기값을 밖에다 써주고
        그리고 do {} while{}로 내용이 실행이 된다.
        이때 while의 조건이 true인지 false인지 대해 돌아야하는지가 결정되어 그값에 따라서 반복문이 실행된다.
        즉 while과 다른점은
        기존 while문은 초기값(i)을 외부에 선언하고 그 초기값이 while문에 들어가는게 참인지 거짓인지 체크해서 
        while반복문을 돌려주었는데,
        do while은 초기값이 와일문의 합당유무에 관계없이 do 내용을 먼저 실행하고 체크를 한다. 
    */
    function doWhileLoopEvents() public{
        uint256 i  = 10;
        do{
            emit cnttIdxNm(i, cntList[i]);
            i++;
        }
        while(i<cntList.length);
    }
    /*
        그러나 여기 do while문을 쓸때 안좋은 점은. 만약 초기값(i)를 10으로 그냥 정해버리면
        cntList길이는 5까지인데 당연히 10은 5보다 크니, 조건(i<cntList.length)에 부합하지 않으나, 
        맨마지막에 늦게해주니, 우선 do문의 함수는 실행이 되고, 그리고 그 10에서 i++에 의해 11로 변하고
        이후 while조건에 판단이 되어진다. 
        즉 그러니까 초기값이 맞지않아도 우선적으로 실행은 된다는 것이다. 
        따라서 10을 입력하고 실행하면 오류는 동일하게 나지만 이미 한번정도는 연산이 된 상태로 오류를 뱉는것이다.

    */
}





    
