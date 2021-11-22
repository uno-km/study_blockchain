//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Functionget {

    // SPDX-License-Identifier: UNLICENSED
    struct St {
        uint no;
        string name;
    }
    St[] public st;

    function setSt(uint_no, string_name) {
        st.push(St(_no, _name));
    }
    function getSt(uint_no) public view returns(uint noo, string namee) {
        noo = st[_num].no;
        namee=st[_num].name;
    }

}


