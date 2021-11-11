//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.10;

contract NonReturnValue {
	uint a = 10;
	uint b = 20;
	function tmp1() public view{
	    a;
	    b;
	}
	
}
