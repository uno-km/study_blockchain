// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    modifier : 이 모디파이어 안에 revert나 , require를 넣어서 주로 사용한다.
    이 모디파이어는 모질이나 미들웨어 처럼 여러 함수에 한번에 적용할 수 있다.
    예를들어서 25강에서 revert, require, assert 이렇게 배울때,
    각함수에 대해 require를 사용했다.
    예를 들어서 
    function onlyAdult2(uint256 age) public pure returns(string memory){
        require(age>19,"You are not allowd to pay for the cigarette");
        return "Your payment is succeded";
    }
    function onlyAdult3(uint256 age) public pure returns(string memory){
        require(age>19,"You are not allowd to pay for the cigarette");
        return "Your payment is succeded";
    }
    이런 함수가 2개 있을때, 
    이 함수는  서로 다르다고 칩시다.
    여기 require는 조건은 같습니다. 예를들어서 나이가 19세 미만인데, 나이제한이 바뀌어서 25세 미만이라고 변경되었다고할때
    두개의 함수 내의 age>19 조건을 바꿔주어야 한다.
    근데 지금 두개의 함수니까 쉽게 바꿀수 있지 만약에 이 함수가 1000개 또는 안보이는 곳에서도 참조를 받고 있을때,
    그 영향도는 상상할수가 없을 정도다.
    반복문제가 아니고 영향도검사도 커진다.
    따라서 이것을 쉽게 바꾸기 위한것이 modifier이다.
    modifier에 대해서 학습해보겠습니다.
*/
contract modifierEx1{
    //주로 파라미터값이 없을때 빈배열()을 넣는것보다 그냥 과감하게 안쓰는 방법이 있다.
    modifier onlyAdults/*()*/{
        revert("You're not allowed to pay for the cigarette");
        _;
        /*
            그리고 이것을 보면 이 함수는 어느부분에 적용된다. 라는 것을 보여준다.즉
             modifier onlyAdults{
                 revert("You're not allowed to pay for the cigarette");
                 function buyCigarette() public onlyAdults returns (string memory){
                return "Your payment is succeeded";
            }
            이런식으로 적용되는것이다. : _; 가 함수 해당 함수를 출력하게 되는것이다.
            그리고 지금 순서상 리턴전에 revert() 가 발동되어 그 하단에 return 이 사용되지않아서
            컴파일러가 오류가 날 것이다.
            이것은 의도한 것이니 . 한번 실행해보자.

        */
    }
    function buyCigarette() public onlyAdults returns (string memory){
        return "Your payment is succeeded";
    }
}
/*
    실행을 한다면 오류가 날것이다. 그리고 revert()경고문이 나왔다.
    하단에 첫번째 스마트컨트랙과 비슷한 컨트랙트를 생성해고 다시 실행해보자.
*/
contract modifierEx2{
    modifier onlyAdults1{
        revert("You're not allowed to pay for the cigarette");
        _;
    }
    function buyCigarette1() public onlyAdults1 returns (string memory){
        return "Your payment is succeeded";
    }
    modifier onlyAdults2(uint256 age){
        require(age>18,"You're not allowed to pay for the cigarette");
        _;
    }
    function buyCigarette2(uint256 age) public onlyAdults2(age) returns (string memory){
        return "Your payment is succeeded";
    }
    /*
        여기서 차이점은 onlyAdults2의 경우 파라미터값이 있는것이다.
        여기서 파라미터 값을 받아서 여기서 18미만은 에러가 나고, 아니면 안나게 할것이다.
        이러면 onlyAdults2에서는 파라미터값이 필요하게되어지고, buyCigarette2에서 값을 받아야한다.
        그리고 받은 age값에 때래서 require를 따라서 18세인지 아닌지 분간을 하여 에러를 츌력할지 안할지 를
        리턴해준다.
        그래서 우리는 이코드를 실행해보자.
        20을 입력하면 잘나오고 13을 입력하면 오류가 나타나낟.
    '*/
    /*그리고 우리는 좀더 추가적으로 _; 에 대해 알아보도록 해보자.*/

    uint256 public num =5;
    modifier  numchang{
        _;
        num=10;
    }
    modifier  numchang2{
        num=10;
        _;
    }
    function numChangeFunction () public numchang{
        num=15;
    }
    function numChangeFunction2 () public numchang2{
        num=15;
    }
    /*만약 이 함수를 실행한다면 num=15되었다가 다시 num=10 이 되는것이다. 그래서 마지막값은 10이 될것이다.
        실행을 해보자.
        최초 num의 값은 5였다가 함수실행후 10이 되었다.
        그래서 각 함수를 2로 하나더 만들고 다신 modifier의 _; 생성시기를 다르게 해보았다.
    */
}