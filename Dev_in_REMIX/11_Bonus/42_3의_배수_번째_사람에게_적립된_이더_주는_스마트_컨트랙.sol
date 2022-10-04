// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0; 
/*
    거의마지막이다.
    기본적인 솔리디티 개념을 알고있어도 막상 스마트컨트랙을 만드려고 하면, 약간 어려울것같아서
    한번 작성해 보았다.
    우선은 3의배수번째의 사람에게 이더주는 스마트컨트랙을 만들어보겠다.
*/
/*
    설계 : Money Box라는 스마트컨트랙을 만들고 해당 컨트랙트는 3의 배수번째로 요청한 사람에게 이더리움을 주는 방식이다.
    첫번째 사람이 MoneyBox에 요청을 한다. 첫번째사람이니 이더를 안준다.
    두번째 사람이 또 요청을 한다. moneybox에서는 다시 순서를 계산하고 3이 아니니 주지않는다.
    서번째 사람이다. 머니박스에서 3의 배수인것을 계산하고 참값이 나왔으므로 이더리움을 주게된다.
    그리고 머니박스의 밸런스는 줄어들게된다.
*/
contract MneyBox{
    event whoPaid(address indexed sender, uint256 payment);
    address owner;
    mapping (uint256 => mapping(address => bool)) paidmemberList;
    uint256 round =1;
    constructor(){
        
    }
}