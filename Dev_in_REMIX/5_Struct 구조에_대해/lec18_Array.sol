// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    배열에 대해서 
    배열은 다른언어와 마찬가지로 값들을 추가하고 삭제하고 길이를 구할 수 있따.
    아전에서 배웠던 mapping과 다르게 길이를 알 수 있다.
    그리고 배열의 좋은 점은, 배열 안의 값들을 쭉 순회할 수 가있다. forlook 을 이용해서
    그러나 솔리디티에서는 배열보다는 mapping을 좀더 선호 한다.
    * 솔리디티에서는 매핑을 좀더 사용하길 원한다. 그 이유는 배열의 좋은 점은 값들을 순환(iteration)할 수 있는 것이지만
    * 이 순환하게 하는 것이 문제가 될 수 있따. 문제? 왜냐하면 이 순환하게 하는것은 디도스 공격에 취약할 수 있다.
    * 예를들어 해커가 이 배열을 악의적으로 특정 배열을 무한 반복을 시킨다면, 가스와 이더리움 네트워크 블록체인을 엄청 과부화 시킬 수 있어서 그렇다.
    * 따라서 이는 디도스 공격을 사용하게끔 할 수 있는 공격의 여지가 될 수 있다.
    * 그렇기 떄문에 배열의 값은 딱 길이를 50으로 사이즈를 제한을 하여 사용하는것을 추천한다고한다. 
    
    그렇다면 우리는 그배열을 어떻게 정의하고 사용하는지 이번 강의를 통해서 알아 보자.
*/
contract ArrayEx1{
    uint256[] public ageArray;  //우리는 간단한 배열을 생성해보았다.
                                //우선 배열을 셍성하기 위해서는 배열의 타입(uint256) 그리고 대괄호('[]'), 그리고 접근제한자 (public)이 있다.
                                //이렇게 배열을 선언했으니 어떻게 추가하고 삭제하고 또 수정하는지 알아봅시다.
    function getAgeArrLength() public view returns (uint256){
        return ageArray.length;
    }// -> 배열의 길이를 구하는 함수이다. 최초엔 아무것도 없을땐 0이 기본값이다.
    function addAgeArrVal(uint256 input) public {
        ageArray.push(input);
    }//입력값은 당연히 uint256이여한다. 왜냐하면 배열의 지네릭은 uint256이라서 
    //만약 추하가한다면 인덱스값은 0부터 카운트들어간다.
    function getAgeArrVal(uint256 idx) public view returns(uint256){
        return ageArray[idx];
    }
    //만약 1이라는 인덱스를 넣으면 2번쨰로 저장된 값이 반환된다.
    /*
        삭제하는 방법은 2가지가 있다. pop과 delete이다.
        ** 만약 pop을 사용하게 된다면.  우리는 인덱스가 0과 1 즉 길이가 2인 배열이 있다고 했을때
        팝을 사용하게되면 최신의 값을 제거한다.
        그러면 제일 최신의 값인 인덱스가 가장높은값이 삭제되는 것이다.(1이 삭제)
        팝을 사용하게되면 가장높은 인덱스의 값이 삭제된다.
        ** 두번째로 delete를 사용하게 된다면. 최신의 값을 지울 필요가 없어진다.
        이제 그 인덱스를 통해서 우리가 원하는 것을 지울 수 있다.
        pop으로는 0, 1중 1부터 지웠지만 인덱스값 0을 우선적으로 지우고싶다면
        인덱스값 0을 입력하고 딜리트해주면된다.
        그러나 delete를 사용하게되면 원하는 인덱스를 넣어서 지울 수 있지만 그것이 완전히 지워지는것이 아니라.
        0으로 채워지기만 하는것이다. 즉 0으로 엎어쳐지는 것이다. 그리고 길이는 변화가 없어진다.
        --
        그래서 우리는 인덱스 0말고 또 다른것을 넣으면 해당값도 0으로 엎어치게된다.
    */
    function deleteAgeArrVal() public{
        ageArray.pop();
    }
    function deleteAgeArrVal(uint256 idx) public{
        delete ageArray[idx];
    }
    function updateAgeArrVal(uint256 idx, uint256 age)public returns(string memory){
        if(ageArray.length>idx){
            ageArray[idx] = age;
            return "success";
        }else{
            return "fail";
        }
    }
    /*
        여기서 주의해야할 점은 0과 1밖에 없는데
        인덱스 3을 넣어서 수정함수를 돌린다면 에러가 발생할 것이다.
        왜냐면 인덱스 밖의 값을 넣었기 때문이다. 따라서 이점을 참고해서 코드를 짜야한다. 
        그럼어떻게 짜야할까? -> 유효성검사 또는 사이즈 체크를 수행하자.
        -- 혼자 if절 넣어서 해본 체크

        ** 추가적으로 현재 이렇게 배열을 선언하면 사이즈가 무제한(*uint256 크기까지) 이여서 보안에 취약하다.
        사이즈를 제한하여 생성해보자.
    */
    uint256[10] public fiexLengthArry;
    /*
        추가로 우리는 배열안의 값들을 미리 선언할 수 있다.
    */ 
    string[3] public memberArray = ['KimUno','LeeSong','HanJin'/*,'test'*/];//만약 3으로 사이즈를 주었는데 4개를 넣으면 오류가날까?
     //오류가 발생한다.
}