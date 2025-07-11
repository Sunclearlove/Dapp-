// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract InsertionSort {
    
    /**
     * @dev 插入排序算法实现
     * @param arr 待排序的数组
     * @return 排序后的数组
     */
    function insertionSort(uint[] memory arr) public pure returns (uint[] memory) {
        // 如果数组长度小于等于1，直接返回
        if (arr.length <= 1) {
            return arr;
        }
        
        // 从第二个元素开始遍历（索引1）
        for (uint i = 1; i < arr.length; i++) {
            uint key = arr[i];  // 当前要插入的元素
            uint j = i;
            
            // 向前查找插入位置
            // 将大于key的元素向右移动
            while (j > 0 && arr[j - 1] > key) {
                arr[j] = arr[j - 1];
                j--;
            }
            
            // 将key插入到正确位置
            arr[j] = key;
        }
        
        return arr;
    }
}