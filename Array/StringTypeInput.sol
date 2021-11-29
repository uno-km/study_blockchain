//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Stringtypeinput {

    struct St {
        uint no;
        string name;

    }
    st[] public st;

    function createSt(uint_no, string_name) {
        st.push(St(_no, _name));
    }

    function getSt(uint _num) public view returns (uint noo, string namee) {
        noo = st[_num].no;
        namee = st[_num].namel
    }
}


