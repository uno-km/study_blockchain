// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
   리니어 서치란?
   우린 길이가 4인 배열이 있다고 한다.
   그리고 그 배열안에는 1,4,3,2 이렇게 생성되어있다.
   그리고 인덱스는 0,1,2,3 이렇게 3까지 있다.
   그리고 search니까 이 배열에 있는 값을 검색을 해서 찾아와야한다.
   그래서 우리는 파라미터값을 3을 넣으면 
   for반복문이 돌면서 입력받은 파라미터값과 if조건문으로 체크를 쭉쭉한다.
   4번 반복되면서 해당 인덱스에 매핑된 배열 값을 비교연산하여 3, 즉 참일경우
   해당 내용이 돌게 하는것이다.
    이것을 구현해 보자.
*/
contract linearSearchEx{
    event cntIdxNm(uint256 indexed idx, string name);
    string[] private counteyList = ["Korea","Jappan","China","U.S.A.","England","France","Germany","Polancd","Rusia","India"];
    //length : 10;
    function linearSearch(string memory input) public view returns(uint256, string memory)
    {
        for(uint256 i=0;i<counteyList.length;i++)
        {
            if(keccak256(bytes(counteyList[i]))== keccak256(bytes(input)))
            {
                return (i,counteyList[i]);
            }
        }
        return (999, "nothing");
    }
    /*
        for 반복문을 돌면서 우리가 입력받은 값이 해당하면 해당 인덱스오 값을 출력하는 함수이다.
        여기서 중요한점은 !!
        keccak256과 bytes를 사용했다.
        여기서 주의해야할점은 솔리디티 내에서는 string타입은 비교불가능 하다.
        예를들어서 다른언어는 "aaa" == "aaa" 이렇게 또는  "aaa".equals, "aaa".isEquals등등 함수가 있는데
        그런 기능이 솔리디티에서는 없다.
        그래서 string과 string을 비교하기 위해서는 해당 if문 처럼
        먼저 string을 bytes 바이트화 시켜줘서 변환해주고, 그다음 
        keccak256라는 내장함수를 사용해서 해쉬화를 시켜주어야한다.
        이렇게 해쉬화를 시켜주면 값이 같을 경우 똑같은 해쉬가 나오니 그것으로 비교연산할수 있는것이다.
        이런 로직들을 이용해서 입력받은것과 해당 배열내의 해당 인덱스에 대해 매핑된 값을 비교할 수 있게된다.
        만약에 해당하지않는다면 if문으로 나오고 for문으로 다 나오게 된다.
        
        - 타이완(Taiwan) 을 입력한다면 배열내에 타이완이없으니 0, nothing이 출력하게 되는것이다.
    */
}

