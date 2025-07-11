// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ContranctStructure {
    uint256 public banlce;

    event BalanceAdded(uint256 oldValue, uint256 incre);

    function getBanlce() public view returns(uint256) {
        return banlce;
    }

    function setBanlce(uint256 num) public {
        banlce += num;
        emit BalanceAdded(banlce, num);
    }
}