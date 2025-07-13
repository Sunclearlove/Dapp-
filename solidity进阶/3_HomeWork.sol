// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**3.编写讨饭合约
合约的目标：
记录捐款人和金额。   用mapping(address => unit)
接收ETH。          写一个donate()，外部可发ETH
提现               withdraw() 只能合约所有者提取全部余额
查询               getDonation(address) 查询捐赠额
安全               使用onlyOwner限制权限
**/

contract BeggingContract {
    // 记录捐赠金额的映射表 （地址 => 金额）
    mapping(address => uint256) public donations;

    // 合约拥有者（就是部署者）
    address public owner;

    //部署时记录合约拥有者 记录“谁部署的合约”，他就是“唯一能提钱的人”
    constructor() {
        owner = msg.sender;
    }

    // 接收 ETH 的函数
    /*知识点
    1.external payable: 表示这个函数可以接受ETH
    2.msg.value 时用户发多少ETH
    donations[msg.sender] += msg.value 把这笔钱加到他的历史捐款
    */
    function donate() external payable {
        require(msg.value > 0, "ETH Must Be greater than zero");
        donations[msg.sender] += msg.value;
    }

    // 只允许合约拥有者提取全部资金
    /*
    知识点：
    1. require(msg.sender == owner) 安全检查
    2. address(this).balance        合约里还剩余多少钱
    3. payable(owner).transfer()    把ETH提给合约的拥有者
    */
    function withdraw() external {
        require(msg.sender == owner, "Only the owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

    // 查询函数 查询某个地址的捐款记录
    function getDonation(address donor) external view returns (uint256) {
        return donations[donor];
    }
}