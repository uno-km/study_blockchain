//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Practice {
    struct Customer{
        uint no;
        string name;
        string level;
    }
    Customer store1 = Customer(1, "KimEunHo","Gold");
    
    function getCustomer() public view returns(uint noo, string namee, string levell){
        noo=store1.no;
        namee=store1.name;
        levell=store1.levell;
    }
}
