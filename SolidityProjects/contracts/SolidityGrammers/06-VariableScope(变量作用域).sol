// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Solidity中变量按作用域划分有三种，分别是状态变量（state variable），局部变量（local variable）和全局变量(global variable)


contract Variables {

    // 1. 状态变量
    // 状态变量是数据存储在链上的变量，所有合约内函数都可以访问，gas消耗高。状态变量在合约内、函数外声明：

    uint public x = 1;
    uint public y;
    string public z;

    function foo() external {
        // 可以在函数里更改状态变量的值
        x = 9;
        y = 1;
        z = "MakeMoney";
    }

    //  2. 局部变量
    // 局部变量是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。局部变量在函数内声明：
    function bar() external pure returns(uint) {
        uint a = 520;
        uint b = 1;
        uint c = a + b;
        return (c);
    }

    // 3. 全局变量
    // 全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用：

    function global() external view returns(address,uint,uint,bytes memory){
        address sender = msg.sender;
        uint blockNumber = block.number;
        uint timestamp = block.timestamp;
        bytes memory data = msg.data;
        return (sender,blockNumber,timestamp,data);
    }

    // 在上面例子里，我们使用了3个常用的全局变量：msg.sender，block.number和msg.data，他们分别代表请求发起地址，当前区块高度，和请求数据。
    // 下面是一些常用的全局变量：
    // blockhash(uint blockNumber): (bytes32) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
    // block.coinbase: (address payable) 当前区块矿工的地址
    // block.gaslimit: (uint) 当前区块的gaslimit
    // block.number: (uint) 当前区块的number
    // block.timestamp: (uint) 当前区块的时间戳，为unix纪元以来的秒
    // gasleft(): (uint256) 剩余 gas
    // msg.data: (bytes calldata) 完整call data
    // msg.sender: (address payable) 消息发送者 (当前 caller)
    // msg.sig: (bytes4) calldata的前四个字节 (function identifier)
    // msg.value: (uint) 当前交易发送的 wei 值
    // block.blobbasefee: (uint) 当前区块的blob基础费用。这是Cancun升级新增的全局变量。
    // blobhash(uint index): (bytes32) 返回跟当前交易关联的第 index 个blob的版本化哈希（第一个字节为版本号，当前为0x01，后面接KZG承诺的SHA256哈希的最后31个字节）。若当前交易不包含blob，则返回空字节。这是Cancun升级新增的全局变量


    // 4. 全局变量-以太单位与时间单位
    // 以太单位
    // Solidity中不存在小数点，以0代替为小数点，来确保交易的精确度，并且防止精度的损失，利用以太单位可以避免误算的问题，方便程序员在合约中处理货币交易。
    // 以太单位有：wei，gwei，ether，finney，szabo，和 ether。
    // wei: 1
    // gwei: 1e9 = 1000000000
    // ether: 1e18 = 1000000000000000000

    function weiUint() external pure returns(uint){
        assert(1 wei == 1e0);
        assert(1 wei == 1);
        return 1 wei;
    }

    function gweiUint() external pure returns(uint){
        assert(1 gwei == 1e9);
        assert(1 gwei == 1000000000);
        return 1 gwei;
    }

    function etherUint() external pure returns(uint){
        assert(1 ether == 1e18);
        assert(1 ether == 1000000000000000000);
        return 1 ether;
    }

    // 时间单位
    // 可以在合约中规定一个操作必须在一周内完成，或者某个事件在一个月后发生。这样就能让合约的执行可以更加精确，不会因为技术上的误差而影响合约的结果。因此，时间单位在Solidity中是一个重要的概念，有助于提高合约的可读性和可维护性。
    // 以太单位有：seconds，minutes，hours，days，weeks，years。
 
    // seconds: 1
    // minutes: 1 minutes = 60 seconds = 60s
    // hours: 1 hours = 60 minutes = 3600s
    // days: 1 days = 24 hours = 24*3600s = 86400s
    // weeks: 1 weeks = 7 days = 604800
    // years: 1 years = 365 days

    function secondsUint() external pure returns(uint){
        assert(1 seconds == 1);
        return 1 seconds;
    }

    function minutesUint() external pure returns(uint){
        assert(1 minutes == 60 seconds);
        return 1 minutes;
    }

    function hoursUint() external pure returns(uint){
        assert(1 hours == 60 minutes);
        return 1 hours;
    }

    function daysUint() external pure returns(uint){
        assert(1 days == 24 hours);
        return 1 days;
    }

    function weeksUint() external pure returns(uint){
        assert(1 weeks == 7 days);
        return 1 weeks;
    }

}