// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// 作业 1：ERC20 代币
/**
任务：参考 openzeppelin-contracts/contracts/token/ERC20/IERC20.sol实现一个简单的 ERC20 代币合约。要求：
合约包含以下标准 ERC20 功能：
balanceOf：查询账户余额。
transfer：转账。
approve 和 transferFrom：授权和代扣转账。
使用 event 记录转账和授权操作。
提供 mint 函数，允许合约所有者增发代币。
提示：
使用 mapping 存储账户余额和授权信息。
使用 event 定义 Transfer 和 Approval 事件。
部署到sepolia 测试网，导入到自己的钱包
**/


contract MyERC20 {
    /*1.
    name、symbol、decimals 是代币基础信息；
    totalSupply 总发行量；
    owner 是管理员地址，只有他可以增发。
    */
    string public name = "MyToken;";
    string public symbol = "MTK";
    uint8 public decimals = 18;
    uint public totalSupply;

    address public owner;

    constructor() {
        /*
        constructor() 是合约的构造函数，部署时执行；
        msg.sender 是部署者的地址，赋值为 owner；
        以后使用 require(msg.sender == owner) 来做权限判断。
        */
        owner = msg.sender;
    }

    /**2.
    添加账户余额与授权数据结构
    balanceOf[地址]：存储每个用户的代币余额；
    写 public 会自动生成一个可查看余额的函数。
    allowance[授权人][被授权人]：被授权人可扣款额度。
    **/
    mapping(address => uint256) public balanceOf;

    mapping(address => mapping(address => uint256)) public allowance;

    /**3.
    日志系统，记录转账行为。
    **/

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    /**4.
    实现transfer函数(基础转账)
    .谁调用函数，msg.sender表示是谁的
    .需要先检查他有没有充足的余额
    .从他账上扣掉aomout
    .给收款人账上加上amount
    .发一个日志事件；
    .返回true表示成功
    **/
    function transfer(address to, uint amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Not enough balance.");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender,to,amount);
        return true;
    }

    /**4
    添加授权函数
    msg.sender 是授权人；
    spender 是被授权人；
    我们在 allowance[授权人][被授权人] 上记录额度；
    emit Approval(...) 是记录日志。
    **/
    function approve(address spender, uint256 amount) external returns (bool) {
    // allowance[owner][spender]	表示 “spender 被 owner 授权可以花多少代币”
    // 例如：allowance[A][B] = 100，就是“B 被 A 授权了 100 个币”。
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
    }

    /**5
    添加transferFrom（代扣转账）

    msg.sender 是要代扣的人（比如商城）；
    from 是授权人（比如自己）
    **/
    function transferFrom(address from, address to, uint amount) external returns (bool){
        require(balanceOf[from] >= amount,"Not enough balance.");
        require(allowance[from][msg.sender] >= amount, "Not enough allowance");

        //扣除额度
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
    	
        emit Transfer(from, to, amount);
    }

    /** 6 mint是干嘛的
        你现在的代币合约，大家能转账、授权、代扣，但没人能“制造”新的币。
        现在我们要给管理员（owner）加一个功能：
        能够向某个地址发放任意数量的新币，并更新总发行量（totalSupply）。

        1 只有 owner（管理员）能执行
        2 balanceOf[to] += amount 给目标地址加币
        3 totalSupply += amount 更新总发行量
        4 emit Transfer(address(0), to, amount) 是 ERC20 标准写法，表示是“增发新币”（从 0 地址转出来）
    **/

    function mint(address to, uint amount) external {
        require(msg.sender == owner, "Only owner can call this.");
        balanceOf[to] += amount;
        totalSupply += amount;
        emit  Transfer(address(0), to, amount);
    }
}