//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Practice2 {

    struct Customer {
        uint no;
        string name;
        string level;
    }
    Customer[] public store1 ;
    function setCustomer(uint _no, string _name, string _level){
        Customer.push(Customer(_no,_name,_level));
    }
    function getCustomer(uint _num) public view returns(uint no, string name, string level){
        no=Customer[no].no;
        name=Customer[name].name;
        level=Customer[level].level;
    }
}


