//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Functionstruct {
    struct St{
        uint no;
        string name;
    }
    St[] public st;
    function createSt(uint_no, string_name){
        st.push(St(_no,_name));
    }
}
