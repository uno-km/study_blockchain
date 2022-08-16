// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec6{
	/*
        storage : 대부분의 변수, 함수들이 저장되며, 영속적으로 저장이되어 비용이 비싸다.
        memory : 함수의 파라미터, 리턴값, 레퍼런스 타입이 주로 저장이 된다.
                그러나, storage 처럼 영속적이지 않고, 함수내에서만 유효하기에 storage 보다 가스 비용이 싸다.
        Colldata : 주로 external function 의 파라미터에서 사용된다.
        stack : EVM (Ethereum Virtual Machine) 에서 stack data를 관리할 때 쓰는 영역인데 1024MB 제한적입니다.
	 */   
    //첫번째로 스토리지 :  storage에 한번 저장되면 영속적인 의미를 가지게 된다. 
    // 영속적인 의미를 가지는 것은 smart 컨트랙트 배포를 하면, 그 함수와 그 변수의 정보들이 블록에 들어간다.
    // 그럼 블록에 들어가니까 모든 노드들이, 모든 사람들이 그 블록을 다운받을 테니까 사용하는 가격이 비싸진다.
    // 따라서 가스비용이 비싸진다 라고 볼 수 있다.
    /*
        두번쨰로 메모리 : 메모리와는 정 반대인데, 함수 값 그리고 함수의 파라미터, 리턴값, 레퍼렌스타입을 쓸때 주로
        메모리를 쓴다고 한다. 
        6강의 read_b() 함수를 보면 unint256 b = 1 ; 를 선언할때 가 메모리에 정의된다고 볼 수 있다.
        그리고 리턴값들, 또 여기 파라미터가 있다면 파라미터도 메모리에 저장된다.
        그러나 메모리는 함수가 작동 할 때만 유효하기에 영속성이 없다.'
        그러기에 storage보다 가스 비용이 덜나간다. 
    */
    /*
        세번째로 Colldata는 주로 익스터널(external function) 의 파라미터에 사용된다. 그리고 stack같은 경우는
        이더리움 버츄얼 머신에 스택데이터를 관리할 때 쓰는 영역이라고 한다. 대신 제한 용량이 있다.
        그래서 우리는 function 에 string을 넣을때 어떤식으로 들어가는지 봐야한다. 
    */
    /*
        function -string.
        string은 기본 데이터 타입이 아니라 레퍼런스에 들어간다.
        그래서 우리가 string을 쓸때 파라미터, 리턴값 또는 함수내에 쓸때 메모리라는 키워드를 붙여주어야한다.
    */
    //functon -string 실습
    function getStr(string memory str) public pure returns(string memory){//리턴되는 것에 메모리라고 지정을 해줘야한다.
        return str;
    }
    function getUint(uint256  ui) public pure returns(uint256){//근데 기본 데이터타입을 쓰면 메모리를 쓸수없다 쓰려하면 컴파일에러 생긴다..
        return ui;
    }
    //여기서 잠깐~!!!! 왜 pure를 썻는가? 스토리지 값을 읽을 필요도 없고, 그리고 스토리지값을 읽어서 바꾸는것도 없고하는 함수내에서만 작업해서 지정함
}