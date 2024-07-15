// SPDX-License-Identifier: MIT


// function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]

// {internal|external|public|private}：函数可见性说明符，共有4种。
// public：内部和外部均可见。
// private：只能从本合约内部访问，继承的合约也不能使用。
// external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
// internal: 只能从合约内部访问，继承的合约可以用。
// 注意 1：合约中定义的函数需要明确指定可见性，它们没有默认值。
// 注意 2：public|private|internal 也可用于修饰状态变量。public变量会自动生成同名的getter函数，用于查询数值。未标明可见性类型的状态变量，默认为internal。

// [pure|view|payable]：决定函数权限/功能的关键字。payable（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入 ETH。
// [returns ()]：函数返回的变量类型和名称

pragma solidity ^0.8.0;

contract FucntionTypes{

    // function add(uint x,uint y) external pure returns(uint){
    //     return x+y;
    // }
    // function sub(uint x,uint y) external pure returns(uint){
    //     return x-y;
    // }
    uint256 public number = 5;

    // 1. pure 和 view
    // pure: 纯纯牛马
    function addPure(uint256 _number) external pure returns(uint256 new_number){
        return new_number = _number + 1;
    }

    // view: 看客
    function addView() external view returns(uint256 new_number){
        new_number = number + 1;
    }

    // payable: 支付
    // function addPayable() external payable returns(uint256 new_number){
    //     new_number = number + 1;
    // }

    // 2. internal v.s. external
    // internal: 内部函数
    function minus() internal{
        number = number - 1;
    }

    // 合约内的函数可以调用内部函数
    function minusCall() external{
        minus();
    }

    // 3. payable
    // payable: 递钱，能给合约支付eth的函数
    function minusPayable() external payable returns(uint256 balance){
        minus();
        balance = address(this).balance;
    }

}
