// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/*
函数选择器
当我们调用智能合约时，本质上是向目标合约发送了一段calldata，在remix中发送一次交易后，
可以在详细信息中看见input即为此次交易的calldata

发送的calldata中前4个字节是selector（函数选择器）

msg.data
msg.data是Solidity中的一个全局变量，值为完整的calldata（调用函数时传入的数据）。

在下面的代码中，我们可以通过Log事件来输出调用mint函数的calldata：
*/
contract Selector {

    // event 返回msg.data
    event Log(bytes data);

    // function mint(address to) external {
    //     emit Log(msg.data);
    // }

    /*
    当参数为  0x2c44b726ADF1963cA47Af88B284C06f30380fC78  时，输出的calldata为
    这段很乱的字节码可以分成两部分：
    前4个字节为函数选择器selector：0x6a627842
    后面32个字节为输入的参数：
    0x0000000000000000000000002c44b726adf1963ca47af88b284c06f30380fc78
    其实calldata就是告诉智能合约，我要调用哪个函数，以及参数是什么

    method id、selector和函数签名
    method id定义为函数签名的Keccak哈希后的前4个字节，当selector与method id相匹配时，即表示调用该函数，
    那么函数签名是什么？

    其实在第21讲中，我们简单介绍了函数签名，为"函数名（逗号分隔的参数类型)"。
    举个例子，上面代码中mint的函数签名为"mint(address)"。在同一个智能合约中，不同的函数有不同的函数签名，
    因此我们可以通过函数签名来确定要调用哪个函数。

    注意，在函数签名中，uint和int要写为uint256和int256。

    我们写一个函数，来验证mint函数的method id是否为0x6a627842。大家可以运行下面的函数，看看结果。
    */

   function mintSelector() external pure returns (bytes4 mSelector) {
        return bytes4(keccak256("mint(address)"));
   }

   /*
   由于计算method id时，需要通过函数名和函数的参数类型来计算。在Solidity中，函数的参数类型主要分为：
   基础类型参数，固定长度类型参数，可变长度类型参数 和 映射类型参数。
   */
}