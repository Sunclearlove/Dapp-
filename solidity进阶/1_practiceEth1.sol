// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// 进阶练习1
/**
练习：实现一个 WETH，将 ETH 包装成 ERC20 WETH （Wrapped ETH） 是ETH 的包装版本。
由于以太币本身并不符合B220 标准，导致与其他代币之间的互操作性较弱，难以用于去中心化应用程序（dApps）。 
本练习要求实现一个符合 ERC20标准的WETH，它比普通的ERC20多了两个功能：
存款和取款，通过这两个功能，WETH 可以1:1兌换ETH.

*@title WETH (Wrapped Ether)
*@notice 把 ETH 包装为 ERC20 Token


知识点： 
external 这个函数只能被别人（合约外部）调用；
payable  这个函数能接收 ETH（不加就会报错）；
mapping 简直对结构
address 用户地址
uint256 无符号整数，代表余额
public  自动生成查询函数，可以balanceOf看余额

msg.sender 是谁调用了函数
msg.value 是他发送了多少eth
**/

contract WETH {
    mapping(address => uint256) public balanceOf;

    // 定义存款取款事件indexedindexed
    /**
    event:声明事件类型
    address indexed： indexed表示这个字段可以被筛选和检索
    uint amount : 存了多少钱/提了多少钱
    **/
    event Deposit(address indexed user,uint amount);
    event Withdrawal(address indexed user,uint amount);

    //存款indexed 
    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // WETH 的提现功能 withdraw()
    /*
    msg.sender 调用者
    payable(...) 让地址具有“收ETH的能力”
    .transfer(amount): 发送amount单位的ETH给这个地址
    0.5eth == 500000000000000000wei
    */
    function withdraw(uint amount) external {
        //添加校验用户想要提amount，检查账户上是否有这么多
        require(balanceOf[msg.sender] >= amount, "Not enough WETH");
        balanceOf[msg.sender] -= amount;
        // 把ETH返还给用户
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
}