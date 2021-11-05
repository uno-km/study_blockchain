//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract Adress {

    function ()payable public {
    }

    function getBalance(address _t) public view returns (uint) {
        if (_t == address(0)) {
            _t = this;
        }
        return _t.balance / 100000000000000000000;
    }

    function transfer(address _to, uint _amount) public {
        _to.transfer(_amount);
    }

    function send(address _to, uint _amount) public {
        if (!_to.send(_amount)) {
            revert();
        }
    }

}


