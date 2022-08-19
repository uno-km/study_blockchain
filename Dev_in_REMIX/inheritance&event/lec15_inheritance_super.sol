// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    상속, super에 대해 학습 : 
    super란? 우리가 함수로 오버라이딩 할때 사용한다. 원래 함수를 갖고온다. 
    예시를 통해 봐보자
*/
contract Father {
    event fatherName(string name);
    function who() public virtual{
        emit fatherName("KimUno");
    }
}
contract Son is Father(){
    event sonName (string name);
    function who() public override{
        emit fatherName("KimUno");
        emit sonName("KimSon");
    }
}
/*
    여기 파더가 선에 상속되어지는 부자관계를 보고있다.
    파더안에는 이벤트 파더네임, 있고 함수 who를 사용하면 파덜네임이 출력되게 된다.
    아들에도 선네임이라고 선이름을 출력하는 이벤트값이 있고, 그리고 who 라는 함수를 아버지 컨트랙으로 부터 상속받아 사용하는것을 알 수 있다.
    그리고 override 하였다. 앞서 서술한 것과 같이. 본래의 값과 스마트컨트랙의 특정한 값을 출력하고 싶은것이다.
    그럼 여기서 보는것과 같이 파덜네임(실제 내이름 김은호)를 입력해주고 선네임(김선) 을 입력하면 출력이 될 수 있다.
    그러나 예를 들어서 이 who 라는 함수 자체가 엄청 길다고 가정하였을때, 우리가 하나하나 써줄수 없다.
    그래서 우리는 super라는 것을 쓴다.
*/
contract Son2 is Father(){
    event sonName (string name);
    function who() public override{
        super.who(); // <------이런식으로 super를 쓰면은 fahther 네임함수를 그자체를 다가져와서 쓸수 있는 것이다.
        emit sonName("KimSon");
    }
}
/*
    선이랑 선2 모두 배포해보자
    그러면 후를 눌러주고 보면 두개의 이벤트가 출력이 된것을 볼 수 있으며,
    파덜네임, 선네임이 모두 출력이 입력한 대로 나온것을 확인 할 수 있다.
*/