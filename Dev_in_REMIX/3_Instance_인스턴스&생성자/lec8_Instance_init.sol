// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    인스턴스를 공뷰한다.
    1. 인스턴스를 쓰는 이유는 : 하나의 컨트랙에서 다른 컨트랙을 접근할때 사용한다.
    예를들어서 하나의 컨트랙에만 모든코드를 넣지 않고, 여러개로 잘라 쪼개서 여러 컨트랙을 만든다.
    여러개로 쪼개지니까 아무래도 어떤 컨트랙에서 여러개의 컨트랙을 이어주어야 하니까 그때 인스턴스를 사용한다고 생각ㅎㅏ면된다.

    쉽게 이해하자면, 우리가 A와 B의 컨트랙 총 2개가 있을떄, 이때 A컨트랙과 B컨트랙을 연결할 것이다.
    그래서 즉, B컨트랙에서 A컨트랙을 사용할 수 있게 되는것이다.
    그래서 A 컨트랙에 간단한 함수와 변수를 선언한다.
*/
contract A{
    uint256 public a =6;
    function change(uint256 inVal) public{ //change함수는 입력받은 파라미터에 값을 대입하는 함수
        a=inVal;
    }
}
contract B{
    A instance = new A();
    function get_A() public view returns(uint256){
        return instance.a();
    }
        function set_A(uint256 inVal) public {
        instance.change(inVal);
    }
}
/*
    만약 B를 디프롤이하고 셋함수로 셋팅하고 A를 다시 디플로이해서 A.a의 값을 본다면
    변함없이 6이 나오는 것을 볼 수 있다. 이것은 인스턴스는 A를 직접 수정하는것이 아닌
    "분신"과 비슷한 참고메모리만 변경하는 것이라서 그렇다.
*/