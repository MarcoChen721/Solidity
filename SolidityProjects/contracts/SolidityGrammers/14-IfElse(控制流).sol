// SPDX-License-Identifier: MIT

// Solidity的控制流与其他语言类似，主要包含以下几种:
// 1-if-else
// 2-for,while,do-while循环
// 3-三元运算符

pragma solidity 0.8.21;
contract InsertionSort{

    // 1.if-else
    function ifElseTest(uint256 number) public pure returns(bool){
        if(number == 1){
            return true;
        }else{
            return false;
        }
    }

    // 2.for循环
    function forLoopTest() public pure returns(uint256){
        uint sum = 0;
        for(uint i = 0;i < 10; i++){
            sum += i;
        }
        return sum;
    }

    // 3.while循环
    function whileLoopTest() public pure returns(uint256){

        uint sum = 0;
        uint i = 0;
        while(i < 10){
            sum += i;
            i++;
        }
        return sum;

    }

    // 4.do-while循环
    function doWhileLoopTest() public pure returns(uint256){
        uint sum = 0;
        uint i = 0;
        do{
            sum += i;
            i++;
        }while(i< 10);
        return sum;
    }

    // 5.三元运算符
    function ternaryTest(uint256 x,uint256 y) public pure returns(uint256){
        return x >= y ? x : y;
        }

    // 用Solidity实现插入排序
    // 插入排序 错误版

    function InsertionSortWrong(uint[] memory a) public pure returns(uint[] memory){
        for(uint i = 1;i < a.length;i++){
            uint temp = a[i];
            uint j = i - 1;
            while((j >= 0) && (temp < a[j])){
                a[j + 1] = a[j];
                j--;
            }
            a[j+1] = temp;
        }
        return a;
    }
    // 原因：Solidity中最常用的变量类型是uint，也就是正整数，取到负值的话，会报underflow错误。而在插入算法中，变量j有可能会取到-1，引起报错。

    // 插入排序 正确版
    function insertionSort(uint[] memory a) public pure returns(uint[] memory){
        for(uint i = 1;i < a.length;i++){
            uint temp = a[i];
            uint j = i; // 即uint j = i - 1 + 1
            while( (j >= 1) && (temp < a[j-1])){
                a[j] = a[j-1];
                j--;
            }
            a[j] = temp;
        }
        return a;
    }
}
