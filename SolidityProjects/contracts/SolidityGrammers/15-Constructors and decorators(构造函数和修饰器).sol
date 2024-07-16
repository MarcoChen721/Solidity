// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Owner{

    // 1-构造函数
    // 构造函数（constructor）是一种特殊的函数，每个合约可以定义一个，并在部署合约的时候自动运行一次。
    // 它可以用来初始化合约的一些参数，例如初始化合约的owner地址：
    address public owner; // 定义owner变量

    // 构造函数
    constructor(address initialOwner) {
        owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
    }

    // 构造函数的旧写法代码示例：
    // pragma solidity =0.4.21;
    // contract Parents {
    //     // 与合约名Parents同名的函数就是构造函数
    //     function Parents () public {
    //     }
    // }


    // 2-修饰器
    // 修饰器（modifier）是Solidity特有的语法，类似于面向对象编程中的装饰器（decorator），声明函数拥有的特性，并减少代码冗余。
    // 穿上它的函数会带有某些特定的行为。modifier的主要使用场景是运行函数前的检查，例如地址，变量，余额等。

    // 定义modifier
    modifier onlyOwner(){
        require(msg.sender == owner); // 检查调用者是否为owner地址
        _; // 执行函数(如果是的话，继续运行函数主体；否则报错并revert交易)
    }

    // 带有onlyOwner修饰符的函数只能被owner地址调用，比如下面这个例子
    function changeOwner(address _newOwner) external onlyOwner {
        owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
    }

    // 注释：定义一个changeOwner函数，运行它可以改变合约的owner，但是由于onlyOwner修饰符的存在，
    // 只有原先的owner可以调用，别人调用就会报错。这也是最常用的"控制智能合约权限"的方法



}