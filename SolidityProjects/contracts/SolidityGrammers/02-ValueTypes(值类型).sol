// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ValueTypes {
    // 1.布尔值
    bool public b = true;
    // 布尔运算
    bool public b1 = !b;
    bool public b2 = b && b1;
    bool public b3 = b || b1;
    bool public b4 = b == b1;
    bool public b5 = b != b1;

    // 2.整型
    int public i = -123;  //整数，包括负数 int = int256 -2**255 to 2**255 -1
                        // int8 -128 to 127
                        // int16 -32768 to 32767

    uint public u = 123;  //正整数 uint = uint256 0 to 2**256 -1
                        // uint8 0 to 2**8 -1
                        // uint16 0 to 2**16 -1
    int public maxInt = type(int).max;  //最大值
    int public minInt = type(int).min;  //最小值
    uint public maxUint = type(uint).max;  //最大值

    // 3.地址类型
    address public addr = 0xF99A2948854F765A6D1343C270f2de8d702B188F;

    // 4.定长字节数组
    // 固定长度的字节数组
    bytes32 public _byte32 = "Helloworld";
    bytes1 public byte1 = _byte32[0];
    // 不定长字节数组
    bytes32 public b32 = 0x89c58ced8a9078bdef2bb60f22e58eeff7dbfed6c2dff3e7c508b629295926fa;
    bytes32 public b33 = 0x4d696e69536f6c69646974790000000000000000000000000000000000000000;    
}