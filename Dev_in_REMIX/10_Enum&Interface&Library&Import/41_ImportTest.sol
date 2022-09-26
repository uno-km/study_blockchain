// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.6.0 < 0.8.0; 

import "./41_Import.sol";
/*앞에 .을 붙이면 해당파일, ..을 붙이면 하위파일*/
/*
    지금 이 41_ImportTest.sol 파일에서 41_Import를 임포트하였다.
    따라서 해당 파일안의 컨트랙트를 이제 사용할 수 있게된것이다.
    그리고 SafeMath0이라는 라이브러리도 호출가능하게 되었다.
*/
contract ImportTest is HiSolidity{
    /*
        SafeMath0라는 라이브러리를 호출하는것이 가능
        import "./41_Import.sol";를통해서 SafeMath0가 정확히 어디있는지 알려주었기 떄문이다.

    */
    using SafeMath0 for uint8;
    uint8 public a;
    function becomeOverflow(uint8 num, uint8 num2) public {
        a = num.add(num2);
    }
    /*
        한번 실행을해서 덧붙여서 설명해보겠다.
        디플로이를 하려고 할때 컨트랙트 콤보박스를 눌러보자. 그러면 해당 콤보박스안에 Import.sol 에 선한 한 스마트컨트랙들도 
        보이는것을 알 수 있다. 이것은 파일이 임포트되었다는것을 알았기 떄문이다.
        그리고 디플로이를 하면 Hi라는 매서드를 사용할 수 있는데 이것은 HiSolidity를 상속받았기 떄문이다. 따라서 Hi를 작동시킨다면
        이벤트가 잘나온것을 확인 할 수 있따.
        더 나아가서 외부라이브러리를 사용해야한다면 
        아까처럼 사용해서 해당 라이브러리를  사용하면 된다.

        만약 더 많은 것들을 사용하고싶다면 웹에서 여러  api를 사용할 수 있다.
        특히 OpenZepplin.com 이 오픈 재플린이란곳은 오픈소스인데
        여기서 NFT토큰 ERC20토큰이든 여러가지 기능을 제공한다. 
        그리고 오픈재플린 소스를 사용하기를 권장한다. 이유는 블록체인 소스는 매우 민감해야한다.
        왜냐하면 돈과 직결된 코드이기 때문이다. 따라서 오픈소스인 오픈재플린에서 
        거의 많은 사람들이 사용하면서 발전시켜와 검증된 코드들을 제공하는 것이다.
        그래서 오픈재플린에서는 ERC721 즉 NFT토큰, ERC20 등등 여러가지의 오픈소스코드를 제공하는데 
        이 재플린 코드를 사용하기를 권장한다.
        그래서 우리는 현재 여기서 제공하는 safeMath 라이브러리를 임포트 해보겠다.
        이 오픈재플린은 구글에 오픈재플린 깃을 검색하면 코드가 나온다.
        우린 우선 임포를 해야힉 때문에 깃허브에 safeMath 주소를 복사해서 임포트 부분에 넣어줘보자
    */ 
}
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/math/SafeMath.sol";
/*
    이렇게 실제 라이브러리를 임포트하였다. 새로 컨트랙트를 만들고 다시 사용해보자.
*/
contract RealLib {
    using SafeMath for uint256;
    uint256 public a;
    uint256 public maximum = 2**256-1; // 2**256 = 2^256
    function becomeOverFlow(uint256 num1, uint256 num2) public {
        a = num1.add(num2);
    }
}