// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
二分查找 (Binary Search)

**/

contract BinarySearch {
    // 在一个升序数组中查找目标值 target
    function binarySearch(uint[] memory arr, uint target) public pure returns (int) {
        int left = 0;
        int right = int(arr.length) - 1;

        while (left <= right ) {
            int mid = (right + left) / 2; // 中间索引
            uint midValue = arr[uint(mid)]; // 获取中间位置的值

            if (target == midValue){
                return mid; // 找到就返回索引
            } else if (target < midValue ) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return -1; // 没找到
    }
}

// 知识点总结
/**
uint[] memory arr	  输入的升序数组，放在内存中处理
返回类型是 int          因为找不到目标时要返回 -1，所以不能用 uint
left, right 是 int	  避免数组越界，并支持负数索引判断
mid = (left + right) / 2	获取中间索引
arr[uint(mid)]	      因为数组索引只能是 uint，所以强制类型转换
比较大小后调整指针	     left = mid + 1 或 right = mid - 1
while (left <= right)  不断缩小范围，直到找到或越界
return -1	            搜索失败时返回 -1 代表“未找到”

**/