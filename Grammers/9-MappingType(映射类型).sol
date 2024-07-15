// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Mapping{

// 映射Mapping
// 在映射中，人们可以通过键（Key）来查询对应的值（Value），比如：通过一个人的id来查询他的钱包地址。
// 声明映射的格式为mapping(_KeyType => _ValueType)，其中_KeyType和_ValueType分别是Key和Value的变量类型。
    mapping(uint => address) public idToaddress; // id映射到地址
    mapping(address => address) public swapPair; // 币对的映射，地址到地址

// 映射的规则
// 规则1：映射的_KeyType只能选择Solidity内置的值类型，比如uint，address等，不能用自定义的结构体。而_ValueType可以使用自定义的类型。

    // 我们定义一个结构体 Struct
    // struct Student{
    //     uint256 id;
    //     uint256 score;
    // }
    // mapping(Student => uint) public testVar; // 该例子会报错，因为_KeyType使用了我们自定义的结构体

// 规则2：映射的存储位置必须是storage，因此可以用于合约的状态变量，函数中的storage变量和library函数的参数。
// 不能用于public函数的参数或返回结果中，因为mapping记录的是一种关系 (key - value pair)。

// 规则3：如果映射声明为public，那么Solidity会自动给你创建一个getter函数，可以通过Key来查询对应的Value。

// 规则4：给映射新增的键值对的语法为_Var[_Key] = _Value，其中_Var是映射变量名，_Key和_Value对应新增的键值对。

    function writeMap (uint _Key,address _Value) public {
        idToaddress[_Key] = _Value;
    }


// 映射的原理
// 原理1: 映射不储存任何键（Key）的资讯，也没有length的资讯。

// 原理2: 映射使用keccak256(abi.encodePacked(key, slot))当成offset存取value，其中slot是映射变量定义所在的插槽位置。

// 原理3: 因为Ethereum会定义所有未使用的空间为0，所以未赋值（Value）的键（Key）初始值都是各个type的默认值，如uint的默认值是0。

}