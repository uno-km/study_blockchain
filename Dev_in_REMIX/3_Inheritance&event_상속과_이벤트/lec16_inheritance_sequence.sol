// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    상속의 순서 : 
    상속의 순서를 학습하여 , super가 어떻게 작동하는지 학습
    쉽게 예시로 확인해보자
*/
contract Father {
    event  fatherName(string name);
    uint256 public money = 0;
    function getName() public virtual{
        emit fatherName("KimFather");
    }
    function setMoney(uint256 inMoney) public{
        money = inMoney;
    }
}
contract Mother{
    event motherName(string name);
    function getName() public virtual{
        emit motherName("KimMother");
    }
}
//contract Son is Father, Mother{
    contract Son is Mother, Father{
    function getName() public override(Father, Mother) {
        super.getName();
    }
    function setFahtersMoney(uint256 money) public{
        super.setMoney(money);
    }
    function getMoney() public view returns(uint256){
        return money;
    }
}
/*
    위처럼 가족관게 스마트컨트랙트가 있다.
    아들은 아빠, 엄마를 상속받고 있다.
    이 중 파더와 마더의 구조는 매우 같다.
    이 파더와 마더는 겟네임 펑션이 있고 같다. 이 선은 겟네임을 오버라이딩 하고있다.
    이 오버라이딩 하고 있는 형태에서 super를 통해여 겟 네임을 있는 그대로 가져오고있다.
    그럼 여기서 어떤 겟네임을 가져오고 있는 것일까?
    한번 실행을 해보면서 확인해 보자
    - 실행결과 : 겟네임을 사용했더니 마더의 함수값이 나온다.
    왜 마더가 나오는가 ? : 상속을 준 마더 스마트 컨트랙이 제일 최신이기 때문이다. 
    그 반대로 말하자면, 이 파더가 맨 오른쪽, 즉 후순위로 선언 하였다면 파더의 겟네임을 사용하게 될 수 있다.
    한번 순서를 바꿔서 배포를 해보자 .

    최종 : 상속의 순서는 맨오른쪽(제일 최근의 것)을 상속받아 실행한다. 만약 같은 함수가 있다면 이때 적용될 것이다.
*/