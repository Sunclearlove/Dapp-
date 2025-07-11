// SPDX-License-Identifier: GPL-3.0

/** 关键字
memory： 内存变量，仅函数执行期间有效，节省 gas
pure：不读也不写区块链状态的函数（不访问 storage）
bytes：Solidity 中处理字符串的底层类型（可索引）
string：表面上是字符串，其实内部就是 bytes
uint： 无符号整数，等价于 uint256
**/

pragma solidity >=0.8.2 <0.9.0;

contract StringReverser {
    // 反转字符串
    // 公共函数 reverse，接收一个字符串参数 str，返回反转后的字符串
    
    function reverse(string memory str) public pure returns (string memory) {
        // 将字符串转换为 bytes 类型（Solidity 中 string 实际是 bytes 的包装）
        bytes memory strBytes = bytes(str);

        // 获取字符串的长度
        uint len = strBytes.length;

         // 创建一个新的 bytes 数组，用来存储反转后的结果
        bytes memory reversed = new bytes(len);

        // 用 for 循环将原字符串从后往前逐个字符复制到新数组中
        for (uint i = 0; i < len; i++) {

            // 从最后一个字符开始放入新的位置：reversed[i] = strBytes[len - i - 1]
            reversed[i] = strBytes[len - i - 1];
        }

        // 将 bytes 类型再转换成 string 类型并返回
        return string(reversed);
        
    }

    // 示例函数 example，调用 reverse 函数，传入 "abcde"，返回 "edcba"
    function example() external pure returns (string memory){
        return reverse("abcde"); // edcba 
    }
}