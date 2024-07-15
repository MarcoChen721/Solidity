// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReferenceTypes{
// 1.数组 array
// 数组（Array）是Solidity常用的一种变量类型，用来存储一组数据（整数，字节，地址等等）。数组分为固定长度数组和可变长度数组两种：

// 固定长度数组：在声明时指定数组的长度。用T[k]的格式声明，其中T是元素的类型，k是长度，例如：
// 固定长度 Array:  
    // uint[8] array1;
    // bytes1[5] array2;
    // address[100] array3;

// 可变长度数组（动态数组）：在声明时不指定数组的长度。用T[]的格式声明，其中T是元素的类型，例如：
// 可变长度 Array:  
    uint[] array4;
    // bytes1[] array5;
    // address[] array6;
    // bytes array7;

// 注意：bytes比较特殊，是数组，但是不用加[]。另外，不能用byte[]声明单字节数组，可以使用bytes或bytes1[]。bytes 比 bytes1[] 省gas。

// 创建数组的规则
// 在Solidity里，创建数组有一些规则：对于memory修饰的动态数组，可以用new操作符来创建，但是必须声明长度，并且声明后长度不能改变。例子：

// memory动态数组
// uint[] memory array8 = new uint[](5);
// bytes memory array9 = new bytes(9);

// 数组成员
// length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。
// push(): 动态数组拥有push()成员，可以在数组最后添加一个0元素，并返回该元素的引用。
// push(x): 动态数组拥有push(x)成员，可以在数组最后添加一个x元素。
// pop(): 动态数组拥有pop()成员，可以移除数组最后一个元素。

    function arrayPush() public returns(uint[] memory){
        uint[2] memory a = [uint(1),2];
        array4 = a;
        array4.push(3);
        return array4;
    }

    function arrayPop() public returns(uint[] memory){
        uint[2] memory a = [uint(1),2];
        array4 = a;
        array4.push(3);
        array4.pop();
        return array4;
    }

    // 结构体 Struct
    // Solidity支持通过构造结构体的形式定义新的类型。结构体中的元素可以是原始类型，也可以是引用类型；结构体可以作为数组或映射的元素。创建结构体的方法:
    struct Student{
        uint256 id;
        uint256 score;
    }

    Student student;// 初始一个student结构体

    // 结构体赋值的四种方法
    // 1-在函数中创建一个storage的struct引用
    function initStudent1() external{
        Student storage _student = student;
        _student.id = 1;
        _student.score = 100;
    }

    // 2-直接引用状态变量的struct
    function initStudent2() external{
        student.id = 1;
        student.score = 80;
    }

    // 3-构造函数式
    function initStudent3() external{
        student = Student(3, 90);
    }

    // 4-key value
    function initStudent4() external{
        student = Student({id:7,score:90});
    }

    function initStudent5() external{
        student.id = 100;
        student.score = 200;
        Student storage _student = student;
        _student.id = 300;
        _student.score = 400;
    }
}