// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Storage {
    string message = "hello world";
    
    function getMessage() public view returns (string memory) {
        return  message;
    }

    function setMessage(string memory msg) public {
         message = msg;
    }
}