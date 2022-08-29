// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    try/catch 에 대해 서 학습해보자
    0.6 버전 이후로 소개가 되었다.
    try/catch 를 쓰게 된 배경은 기존의 에러핸들러 assert, revert, require 같은 경우는 에러를 발생시키고 프로그램을 바로 
    종료시켰지만, 이 try/catch는 에러가 나도, 에러가 catch로 들어감으로써 이 프로그램이 종료되지 않는다. 
    catch에 들어간 코드는 우리가 코드를 작성한것에 의해서 동작하고 조치가 된다.
    그래서 이럴때 에러를 조치할때 사용된다. 
    이 try/catch는 3가지 특징이 있다.
    1. try/catch 문 아래서 에러가 발생한다면, catch는 그 에러르 잡지 못한다.
    그 이유는 이 솔리디티가 try/catch문에서 에러가 난것은 개발자가 의도한지 알고 프로그램을 정상적으로 끝내버린다.
    그러면 언제 어디서 tc가 작동하냐면, try/catch문 밖에서 이 assert, revert, require 와 같은 에러가 난다면, 그 에러는 catch로 들어간다.
    그래서 우리는 그 catch로 들어간 에어를 핸들, 다룰수 있다.

    2. 그리고 두번째는 catch에는 3가지 종류가 있다.
    2-1 catch는 에러, 
    2-2 panic 패닉,
    2-3 그냥 catch 이다.
    그래서 첫번째 catch에러는 주로 revert 냐 require을 통해 생성된 에러 용도이다.
    그리고 두번째 panic같은 경우는 assert를 통해서 생성된 에러를 다루는데 ,  지난번 강의때와같이 어설트는 주로 테스트때 사용되는데
    이 assert의 에러는 이더리움에서 10가지 정도 정의를 하고있다.
    ----------10가지 정의 ---------------
    0x00 : Used for generic compiler inserted panics.
    0x01 : If you call assert with an argument that evaluates to false.
    0x11 : If an arithmetic operation results in underflow or overflow outside of an unchecked { ... } block.
    0x12 : If you divide or modulo by zero (e.g. 5/0 or 0 or 23 % 0).
    0x21 : If you convert a value taht is too big or negative into an enum type.
    0x22 : If you access a storage byte array that is incorrectly encoded.
    0x31 : If you call .pop() on an empty array.
    0x32 : If access an array, bytesN or an array slice at an out-of-bounds or negative index(i.e. x[i] wh)
    - 배열의 인덱스가 음수이거나 , 그 배열의 인덱스가 지났을때 
    0x41 : If allocate too much memory or create an array that is too large.
    0x51 : If call a zero-initialized variable of internal function type.
    ------------------------------------
    이렇게 10가지 정도의 에러에 의해서 나타나면 이 에러코드가 나타나면서 출력된다.
    예를 들어서 divition에러를 낸다고 했을 때, 이렇게 16진수로 0x12 , 12가 나오는데,
    16진수의 12의 에러코드의 값은 의 18이다. 즉 그러니까 우리가 어떤 에러를 냈을때
    try/catch 문에서 이 에러코드를 출력을 한다면 12, 즉 0x12(=18) 에러코드가 나온다.
    그리고 우리가 참고해야할 것은ㄷ
    panic은 0.8 버전 이전에는 없고, 0.8.1 버전부터 있다.
    그래서 0.8.0 버전 이전에는 catch가 
    
    catch Error(string memory reson) { ... } : revert or requre을 통해 생성된 에러용도 V <--0.8.0 이전에 존재
    catch(bytesmemorylowLevelData) { ... } : 이 catch는 로우 레벨에러를 잡는다. V <--0.8.0 이전에 존재
    
    catch Panic (uint errorCode) {... }  : assert를 통해 생성된 에러가 날 때 이 catch에 잡힌다.  <--0.8.1 이후 생성

    그래서 이 3가지의   try/catch는 어디서 사용되어야하는지 알아보자.
    주로  try/catch가 소개된 이유는 외부 스마트 컨트랙 함수를 부를때, 외부 스마트컨트랙을 생성할때
    주로 쓰게하려고 도입이 되었다고 한다.
    그래도 스마트컨트랙내 함수를 부를때도  try/catch을 쓸 수 있다. this를 통해  try/catch를 쓴다.

    외부 스마트 컨트랙을 호출할때 : 예를들어 스마트컨트랙이 2가기있고, try/catch가 있는 스마트컨트랙에서 다른 스마트컨트랙의 함수를
    부를때 그때  try/catch를 쓸수있고
    외부 스마트 컨트랙을 생성할때 : 인스턴스화 할때  try/catch를 쓸 수 있다.
    내부 스마트컨트랙 내에서 함수를 부를때 : this를 통해  try/catch를 쓴다.

    그래서 우린 우선 외부 스마트컨트랙 함수를 부를때에 대해 알아보자.
*/
/*
    예제설명 : 우린 우선 2개의 스마트 컨트랙을 만들었다.    
    이때 러너에는  try/catch문이 있다.그리고 math에는 division이라는 함수가 있다.
    그래서 외부 스마트 컨트랙 함수를 부를때니까 이  try/catch문이 들어있는 컨트랙에서 이 외부함수 math의 함수를 부를때다.
    그래서 math의 함수를 부를때  try/catch 문을 사용할 것이다.
    이때 math의 함수를 보면 그냥 나누기이다. 그런데 이때 0을 나누게 되면 해당하는 오류가 나타날것이다.
    그리고 10이상의 경우 에러가 require를 통해서 나타도록 하였다.
*/
contract Math{
    function division(uint256 num1, uint256 num2) public pure returns (uint256){
        require(num1<10, "num1 shoud not be more than 10");
        return num1/num2;
    }
}
contract Runner{
    /*
        이제 이 스마트 컨트랙을 보자면
        우선 3개의 이벤트를 만들었다.
        이 3개의 캐치가 있다.
        에러, 패닉, 그냥 캐치, 이렇게 있다.
        이 에러가 났을 때 , catch가 잡았을 때, 그 값을 출력해주도록 만들었다.보기쉽게!
        그래서 예를들어서 catch 에러에는 캐치에러함수가 나오고 해당 string이 출력되고 , 이벤트가 나타나도록 해다.
        각각 에러에 대해 3가지 중 하나가 적용되어 출력되도록 하였다.

        그래서 우리는 외부 스마트 컨트랙을 호출해야하니까 math를 인스턴스화 해야한다.
        그래서 우리는 math를 인스턴스 화 new 를 하였고, 이제 math.division을 통해 불러서 사용할 수 있다.
    */
    event catchErr(string name, string err);
    event catchPanic(string name, uint256 err);
    event catchLowLevelErr(string name, bytes err);
    /*이제 math의 division 함수내에 입력받은 숫자들을 나누고 실행되어야하니까 파라미터값 2개를 받야아한다. */
    function playTryCatch(uint256 num1, uint256 num2) public returns (uint256, bool)//그리고 플래이try/catch함수에 리턴값 uint256과 try/catch문이 잘잘동했는지에 대한 불리언값도 리턴을 하게한다.
    {
        Math mathInstance = new Math();
       /*그래서 우리는 try를 먼저 써주고, division을 써주고 매스인스턴스로 접근한다. 그리고 입력받은 넘버원 넘버투를 준다.
        그리고 넘버원, 넘버투는 플레이try/catch의 함수실행시 입력한 파라미터 2개여야한다.
        그리고 이 division함수는 리턴을 하는데, 그래서 해당 함수에 returns 도 따로 아래처럼 써주어야한다.
        value를 써주어야 division함수에 대한 리턴값을 얻어와서 playtry/catch에 내보낼수있다.
        이렇게 쓰는게 다소 생소할 수 있다. 그러나 이것에 대해서 다다음 강의에 다시 설명을 들어보자.
       */
        try mathInstance.division(num1,num2) returns(uint256 val)
        {
            return(val,true);
        }
        catch Error(string memory err)
        {
            emit catchErr("revert/requre",err);
            return (0,false);
        }
        catch Panic(uint256 errCode)
        {   
            emit catchPanic("assertError/Panic", errCode);
            return (0,false);
        }
        catch (bytes memory errCode)
        {
            emit catchLowLevelErr("LowlevelError", errCode);
            return (0,false);
        }
    }
}