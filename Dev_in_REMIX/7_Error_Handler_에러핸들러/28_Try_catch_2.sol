// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    Try/Catch는 어디서 쓰는가?
    이번 강의에서는 지난 번강의에 이어서 Try/Catch에 대해 더 알아보자.
    지 난번 강의때 외부 스마트컨트랙트 함수를 볼때 Try/Catch 를 사용했다.
    
    이번엔 
    1. 외부 스마트컨트랙을 생성할 때.
    2. 스마트컨트랙 내에서 함수를 부를때.
    
    Try/Catch 를 어떻게 쓰는지 알아보자.

  
*/
//  -> 1. 외부 스마트컨트랙을 생성할때 
/*
    우선 외부 스마트컨트랙을 생성할때 니까 외부스마트컨트랙인 케릭터를 만들었다.
    먼저 이 컨트랙트를 보면 이름과 파워를 생성한다. 그래서 이 컨트랙을 인스턴스화 할때
    이름과 파워를 필수적으로 넣어주어야한다.
*/ 
contract character{
    string private name;
    uint256 private power;
    constructor(string memory inName, uint256 inPower){
        /*revert("error");*/
        name = inName;
        power = inPower;
    }
}

contract Excute{
    /*
        트래이 캐치문은 Excute 함수에있다.
        그리고 여기 안에는 catchOnly 이벤트와 playTryCatch함수가 있다.
        playTryCatch 안에는 이 charactor를 인스턴스화 하는것이 있는데, 당연히 이 인스턴스 할때 
        이름과 파워가 필요하니, 플래이트라이캐이에도 당연히 이름과 파워를 입력받아서 
        케릭터라는 컨트랙트의 인스턴스화 할때 넣어준다.
        그리고 눈에 띄이는 것은. 여기서는 catch만 써주었다.
        지난강의에서는 3개의 캐치를 사용했다. (1. Error, 2. Panic, 3. 그냥 캐치)
        예를 들어 우리가 catch를 꼭 안써주고, catch 쓰는게 귀찮을 수 도 있고?
        그리고 catch를 써서 어떤 에러인지 각각 잡을 필요가 없을때도 있다.
        그럴 때 우리는 catch만 써주어도된다. 그럼 에러,패닉 등이 없어도 모든 오류는 잡아줄수있다.
        따라서 사용할때 Error라던가 Panic 이라던가 긴 괄호 등을 없애주고 사용해도 된다.
        간결해진 try/catch를 봐보자
    */
    bool public val = true;
    event catchOnly(string name, string err);
    function playTryCatch(string memory inName, uint256 inPower) public returns(bool){
        
        try new character(inName, inPower){
            revert("error in the try/catch block");
            return(val);
        }catch{
            emit catchOnly("catch","ErrorS!!");
            return(!val);
        }
    }
    //만약 여기 글자들을 넣고 돌리다가 에러가 나면 캐치문으로 가서 리턴을 받게된다. 
    /*
        컴파일을하고 알아보자.
        우선 값을 string타입엔 kim을, uint256 입력하는 파워엔 100을 입력했더니 정상작동한다.
        이제 캐치로 빼기위해서 일부러 revert를 사용하여 오류를 내보자.
        revert("error"); 
        를 추가해서 억지로 에러를 냈더니 캐치온리 이벤트가 발생하는것을 볼 수 있따.

        확인하면 주석처리를 해주겠다.

        추가적으로 지난강의에서 27쪽 메모한것을 보면 try/catch내 일부러 오류를 내면 사용자가 억지로 낸줄알고 프로그래밍을
        종료한다고 한다. 한번 확인해보자.
        revert("error in the try/catch block");
        를 통해서 확인해보도록 하겠다.
        배포를 해보자.
        그러면 오류가 발생한다. 그리고 리턴값은 true가 나온것을 볼 수 있다.
        캐치는 전혀 잡히지가 않는다. 이 말은 즉슨 try안에 우리가 revert나, requre, assert 등 에러를 낸다면
        try catch문은 멈춘다는것을 알 수가있다.
    */
}
/*2. 스마트컨트랙 내에서 함수를 부를때 사용하는 try/Catch*/
contract Excute2{
    /*
        우린 익스큐트2라는 컨트랙을 만들었다.
        이 컨트랙 내에서는
        simple함수와 캐치온리 이벤트, 플레이트라이 캐치 함수가 있다.
        먼저 이 심플 함수는 4라는 값을 리턴한다. 그리고 스마크컨트랙 내에서 함수를 부르는 것이니까,
        playTryCatch 함수 내에서 선언할때 this.simple()을 붙여 주었다.
        this. 라는 전역변수를 사용해주므로서 스마트 컨트랙 내에서  접근을 한다.  
        this.라은 것은 스마트 컨트랙 내에 또는 Excute2를 지칭하는 것과 개념과 같다.
        그래서 try 하고 this.simple() 한 후에 마찬가지로 리턴을 4를 받으니까.
        그 4가 값에 들어간다. 
        우선을 이것을 실행해보자.

    */
    function simple(uint256 inNumb) public pure returns(uint256){
        return inNumb;
    }
    event catchOnly(string name, string err);
    function playTryCatch(uint256 inNumb) public returns (uint256, bool){
        try this.simple(inNumb) returns (uint256 val){
            return(val, true);
        }catch{
            emit catchOnly("catch!!!","ErrorS!!");
            return (0,false);
        }
    }
    /*
        우선 배포를 해서 정상작동을 시키면
        트루가 되어 정상작동이된것을 볼 수 있다.
        글고 uint256rkqtdl 4가 나온것을 볼 수 있다.
    */
}