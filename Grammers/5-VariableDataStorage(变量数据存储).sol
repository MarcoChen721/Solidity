// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 数据位置和赋值规则

contract DataStorage {
    // 数据位置
    // Solidity数据存储位置有三类：storage，memory和calldata。不同存储位置的gas成本不同。storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少。
    // 大致用法：
    //          storage：合约里的状态变量默认都是storage，存储在链上。
    //          memory：函数里的参数和临时变量一般用memory，存储在内存中，不上链。尤其是如果返回数据类型是变长的情况下，必须加memory修饰，例如：string, bytes, array和自定义结构。
    //          calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数.

    uint[] x = [1,2,3]; // 状态变量，数组x

    // 数据位置和赋值规则
    // 在不同存储类型相互赋值时候，有时会产生独立的副本（修改新变量不会影响原变量），有时会产生引用（修改新变量会影响原变量）。规则如下：
    // 赋值本质上是创建引用指向本体，因此修改本体或者是引用，变化可以被同步：
    // storage（合约的状态变量）赋值给本地storage（函数里的）时候，会创建引用，改变新变量会影响原变量。
    // storage（合约的状态变量）赋值给memory（函数里的）时候，会创建副本，改变新变量不会影响原变量。
    // memory（函数里的）赋值给storage（合约的状态变量）时候，会创建副本，改变新变量不会影响原变量。
    // memory（函数里的）赋值给memory（函数里的）时候，会创建引用，改变新变量会影响原变量。
    // 总结：
    // 1. storage类型的变量赋值给storage类型的变量，会创建引用，改变新变量会影响原变量。
    // 2. storage类型的变量赋值给memory类型的变量，会创建副本，改变新变量不会影响原变量。
    // 3. memory类型的变量赋值给storage类型的变量，会创建副本，改变新变量不会影响原变量。
    // 4. memory类型的变量赋值给memory类型的变量，会创建引用，改变新变量会影响原变量。
    // 注意：
    // 1. 函数参数默认是memory类型，如果函数参数是storage类型，需要加关键字memory。
    // 2. 函数参数默认是calldata类型，如果函数参数是storage类型，需要加关键字storage。
    // 3. 函数返回值默认是calldata类型，如果函数返回值是storage类型，需要加关键字storage。
    // 4. 函数返回值默认是calldata类型，如果函数返回值是storage类型，需要加关键字storage。

    // 1-storage（合约的状态变量）赋值给本地storage（函数里的）时候，会创建引用，改变新变量会影响原变量。
    function fStorage() public{
        // 声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
        uint[] storage xStorage = x;
        xStorage[0] = 100; // 修改状态变量x
    }

    // 2-storage（合约的状态变量）赋值给memory（函数里的）时候，会创建副本，改变新变量不会影响原变量。
    function fMemory() public view{
        // 声明一个memory的变量 xMemory，指向x。修改xMemory不会影响x
        uint[] memory xMemory = x;
        xMemory[0] = 200; // 修改内存变量xMemory
        xMemory[1] = 201; 
        uint[] memory xMemory2 = x; // 创建副本，不会影响x
        xMemory2[0] = 303; // 修改内存变量xMemory2
    }
    // 3-memory赋值给memory，会创建引用，改变新变量会影响原变量。
    // 4-其他情况，变量赋值给storage，会创建副本，改变新变量不会影响原变量。
    
    function fCalldata(uint[] calldata _x) external pure returns (uint[] calldata) {
        // 参数为calldata数组，不能被修改
        // _x[0] = 0 //这样修改会报错
        return (_x);
    }
}
