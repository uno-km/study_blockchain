// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    반복문의 키워드 continue, break에 학습
    1. continue는 다음 반복문으로 이동시키는 키워드
    2. break는 현 반복문을 끝내는 키워드
    그래서 우리는 일단 continue를 학습한다.
*/
contract loopKeywords{
    event cntIdxNm(uint256 indexed idx, string name);
    string[] private cntList = ["Korea,","Jappan","China","U.S.A.","England","France","Germany","Polancd","Rusia","India"];
    //length : 10;
    function useContinue() public {
        for(uint256 i=0;i<cntList.length;i++){
            if(i%2==1)/*odd(홀수)일경우*/{
                continue;
            }else{
                emit cntIdxNm(i,cntList[i]);
            }
        }
    }
    /*
        forloop을 이용해서 if문을 이용해서 특정한 액션 또는 특정한 값에만 동작하도록 할 수 있다.
        이런식으로 홀수일때는 넘어가고 짝수일 때만 돌아가는 형식으로 만들 수 있다.
    */
    //2. break : 브레이크를 만나면 반복문을 끝낸다.
    function useBreak() public{
        for(uint256 i=0;i<cntList.length;i++){
            if(i==7){
                break;
            }else{
                emit cntIdxNm(i,cntList[i]);
            }
        }
    }
    /*
        7번째 인덱스에서 끝나서 
        6번 독일까지만 출력된것을 확인 할 수 있다.
    */
}