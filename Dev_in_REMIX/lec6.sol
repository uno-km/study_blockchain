// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec5{
   /*
    접근제한자 : public, private, internal, external 이렇게 있으며 변경가능하다
    public : 모든곳에서 접근가능 
    external : 퍼블릭과 유사하나, 오직 자기 contract 이 아닌, 다른 contrack 이 접근할때 사용된다.
    private :  오직 private이 정의된 자기 contract 가 정의된, 즉 사적에게 컨트렉에서만 그 값이 접근이 된다.
    그리고 private이 정의된 contract를 상속 받은 자식도 해당 private가 있는 함수 사용을 할 수 없다.
    internal : private과 유사한, 상속받은 contract도 접근이 가능하다. 
   */
   //example :
   //1.public
   uint256 public a= 5;
   //2. private 
   uint256 private a2 = 3; // 원래 이상태로 배포하면 a,a2가 보여야하는데  근데 지금 private를 썻기때문에
   // 디플로이 해도 접근을 하지 못했다. 왜냐면 배포한 곳은 스마트컨트랙트 내가 아니라 밖이라서 접근이 되지않는다.
   
}
//1-public으로 하면 잘된다.
//2-private로 하니 Public_Ex2의 changeA2함수에서 에러가 난다. -내용 : private써서 접근을 할 수 없어서 나는 에러이다.
//3-external로 하니 잘된다. 왜냐면 다른 외부의 컨트랙을 적용하니까 되는것이다.
//4-internal로 사용 : internal contract  <- internal contract child contract 는 해당 변수나 함수가 접근가능하다.

contract Public_Ex1 {
    uint256  public /*external*/  a = 3;//얘를 익스터널로 하면 에러발생 : 익스터널이 정의된곳에서 a를 사용했기 때문이다.
    //만약 익스터널인 a를 사용하기 위해서는 차라리 다른 컨트랙트에서 사용해야한다.
    function changeA(uint256 inVal) /*public*/ /*private*/ external {
        a = inVal;
    }
    function get_a() view   /*public*/ /*private*/ external  returns (uint256){ //우선 이론상 이 퍼블릭함수는 어디서든 쓸수있다. = 퍼블릭이 있으니까!
        return a;
    }
}
contract Public_Ex2{
    Public_Ex1 instance = new Public_Ex1(); // 우리가 선언한 Public_Ex1 컨트랙트를 사용하기 위해서는 인스턴스를 생성해야한다. - 자바 클래스호출과 같음
    function  changeA2(uint256 inVal) public{
        instance.changeA(inVal);
    }
    function usePublicExA() view public returns (uint256){
        return instance.get_a();
    }
}