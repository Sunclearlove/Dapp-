// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
* @title 合并两个有序数组
*
* memory: 内存数据，不保存在区块链中
* new uint[]()：  在内存中创建动态数组
* while： 循环  逐个比较合并两个数组
* result[k++] = A[i++]： 等价于先赋值再加指针
*
**/

contract MergeSortedArrays {

// 合并两个升序数组为一个升序数组
    function mergeSortedArrays(uint[] memory array1, uint[] memory array2) public pure returns (uint[] memory) {
        uint length1 = array1.length;
        uint length2 = array2.length;
        
        // 创建一个新数组，长度为两个数组之和
        uint[] memory result = new uint[](length1 + length2);
        
        // 三个索引指针
        uint index1 = 0; // 指向 array1
        uint index2 = 0; // 指向 array2
        uint resultIndex = 0; // 指向结果数组 result
        
        // 比较两个数组的当前元素，把较小的放入 result
        while (index1 < length1 && index2 < length2) {
            if (array1[index1] < array2[index2]) {
                result[resultIndex] = array1[index1];
                index1++;
            } else {
                result[resultIndex] = array2[index2];
                index2++;
            }
            resultIndex++;
        }
        
        // 把 array1 剩下的元素全部放进 result
        while (index1 < length1) {
            result[resultIndex] = array1[index1];
            index1++;
            resultIndex++;
        }
        
        // 把 array2 剩下的元素全部放进 result
        while (index2 < length2) {
            result[resultIndex] = array2[index2];
            index2++;
            resultIndex++;
        }

        return result;
    }

    // 示例函数：合并 [1,3,5] 和 [2,4,6]
    function example() external pure returns (uint[] memory) {
        uint[] memory array1;
        array1[0] = 1;
        array1[1] = 3;
        array1[2] = 5;

        uint[] memory array2;
        array2[0] = 2;
        array2[1] = 4;
        array2[2] = 6;

        return mergeSortedArrays(array1, array2); // 返回 [1,2,3,4,5,6]
    }
}