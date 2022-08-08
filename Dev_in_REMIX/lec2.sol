// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec2{
    //data  type 은
    // boolean bytes, address, uint  가 있으며
    // reference type으로는
    // string, Arrays, struct

    // mapping type

    // boolean :L true/false
    bool public bol = false;
    //boolean에도 !낫 연사자등이 있다!
    bool public bol1 = !false; //true
    bool public bol2 = false || true; // true
    bool public bol3 = false == true; // false
    bool public bol4 = false && true; // false
    // bytes :  
    bytes4 public bt = 0x12345678;
    bytes public bt2 = "STRING";
    bytes public bt3 = "HiMynameisUnokim.";
    //어드레스 : 다른언어에 없는 타입이다. 
    // 은행계좌를 개설하면 고유 계좌인데 마찬가지로 그런 계좌번호라고 생각하면된다.
    // 이더를 송수신할때 이 어드레스를 통해서 주고받고  
    // 어드레스는 사람에게만 부여되는게 아니라. 스맡컨트랙을 배포할 때도 어드레스가 발생한다. 
    // 즉 스마트 컨트랙 마다 배포가 되면은 어드레스가 생간다. 
    //address :  0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47
    //0xd9145CCE52D386f254917e481eB44e9943F39138
    address public addr = 0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47;
    // int vs uint  : -가 있냐 없냐의 차이다. 
    // int8 : -2^7 ~ 2^7-1
    // uint8 : 0~2^8-1 
    int8 public  it =4;
    uint256 public uit = 132213;
    int  public it1 = 0;//+ * - 해줄수가있다
    uint32 public uit2 = 25624242; 
}