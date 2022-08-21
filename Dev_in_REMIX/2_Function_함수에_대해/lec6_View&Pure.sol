// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec6{
	/*
	 * 	function get_a() view external returns (uint256)
	 * 여기에 view 또는  pure가 들어갈 수 있다.
	 * 그리고 이 view를 접근 제한자 앞뒤로도 사용할 수 있다.
	 * 
	 * 먼저 view와 pure 는
	 * view : function 밖의 변수들을 읽를 수 있으나, 변경 불가능
	 * pure : function 밖의 변수들을 읽지 못하고, 변경도 불가능
	 * view/pure 둘다 명시 안할 때 : function 밖의 변수들을 읽어서, 변경을 해야함
	 * 이정도로 간단하게  이해해보자
	 * 
	 */   
     //1. view
     uint256 public a = 1;
     function read_a() public view returns(uint256){
         return a+2;
     }
     //^^^여기 위의 view는 펑션 밖의 변수를 가져올 수 있고 읽을 수 있다. 
     // + 그리고 플러스 + 2 를 하면 변경은 불가능하니 이게 될수 없다. 그래서 컴파일러 오류가 난다.
     // 따라서 디플로이하고 a값을 보고(1) 이후 함수를 실행하고 (a+2=3) 그리고 나서 또 a를 누르면 3이 되어야하는데 1만 나오고있다.
     //2. pure 
     function read_b() public pure returns(uint256){
         // 만약 a+1; 이걸쓰면 컴파일러 에러가 뜬다
         uint256 b = 1;
         return 4+2+b;
     }
     // 그리고 퓨어와 뷰를 사용할때 옆에 값들이 나오지만 둘다를 사용안하면 주황색 버튼으로 나온다.
     //3. 둘다 사용안할 때
     
     function read_c() public returns(uint256){
         a = 3;
         uint256 b = 1;
         return 4+2+b+a;
     }
}