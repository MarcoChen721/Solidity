// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 值类型初始值
// boolean: false
// string: ""
// int: 0
// uint: 0
// enum: 枚举中的第一个元素
// address: 0x0000000000000000000000000000000000000000 (或 address(0))
// function
// internal: 空白函数
// external: 空白函数

// 引用类型初始值
// 映射mapping: 所有元素都为其默认值的mapping
// 结构体struct: 所有成员设为其默认值的结构体
// 数组array
// 动态数组: []
// 静态数组（定长）: 所有成员设为其默认值的静态数组

// 可以用public变量的getter函数验证上面写的初始值是否正确

contract DefaultValues {

    // 值类型初始值
    bool public b; // false
    uint public u; // 0
    int public i; // 0
    string public str; // ""
    address public _address; // 0x00000000000000000000000000000000
    bytes32 public b32; // 0x0000000000000000000000000000000000000000000000000000000000000000

    enum ActionSet{Buy,Hold,Sell}
    ActionSet public _enum; // 0

    function fi() internal{} // internal空白函数
    function fe() external{} // external空白函数

    // 引用类型初始值
    uint[8] public _staticArray; // 所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
    uint[] public _dynamicArray; // `[]`
    mapping(uint => address) public _mapping; // 所有元素都为其默认值的mapping

    struct My_Struct{
        uint256 id;
        uint256 scores;
    } // 所有成员设为其默认值的结构体 0, 0

    My_Struct public my_struct; //

    // delete操作符
    // delete a会让变量a的值变为初始值。
    bool public _bool = true;
    function d() external{
        delete _bool; // delete 会让_bool2变为默认值，false
    }

}