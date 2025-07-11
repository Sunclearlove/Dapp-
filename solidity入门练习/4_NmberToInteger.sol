// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 整数转化罗马数字
contract NumberToInteger {
    uint16[] private values = [
        1000, 900, 500, 400,
        100, 90, 50, 40,
        10, 9, 5, 4, 1
    ];

    string[] private numerals = [
        "M", "CM", "D", "CD",
        "C", "XC", "L", "XL",
        "X", "IX", "V", "IV", "I"
    ];

    // 将整数转换为罗马数字
    function toRoman(uint num) public view returns (string memory) {
        require(num > 0 && num < 4000, "Out of range (1~3999)");

        bytes memory result;

        for (uint i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                result = abi.encodePacked(result, numerals[i]);
                num -= values[i];
            }
        }

        return string(result);
    }

    // 示例：toRoman(1994) -> "MCMXCIV"
}