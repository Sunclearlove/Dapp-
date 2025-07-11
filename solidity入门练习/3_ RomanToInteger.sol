// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanMappingExplanation {
    //罗马数字转换整数
    
    // ========== 方法1：状态变量映射 ==========
    // 这是最直观的方式，但会消耗更多gas，因为涉及存储读取
    mapping(bytes1 => uint) public romanToValue;
    
    constructor() {
        // 在构造函数中初始化映射
        romanToValue['I'] = 1;
        romanToValue['V'] = 5;
        romanToValue['X'] = 10;
        romanToValue['L'] = 50;
        romanToValue['C'] = 100;
        romanToValue['D'] = 500;
        romanToValue['M'] = 1000;
    }
    
    function romanToIntWithMapping(string memory s) public view returns (int) {
        bytes memory romanBytes = bytes(s);
        int result = 0;
        int prevValue = 0;
        
        // 从右到左遍历
        for (int i = int(romanBytes.length) - 1; i >= 0; i--) {
            int currentValue = int(romanToValue[romanBytes[uint(i)]]);
            
            if (currentValue < prevValue) {
                result -= currentValue;
            } else {
                result += currentValue;
            }
            
            prevValue = currentValue;
        }
        
        return result;
    }
}