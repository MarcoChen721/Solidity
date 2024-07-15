// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/*
在Solidity中，import语句可以帮助我们在一个文件中引用另一个文件的内容，提高代码的可重用性和组织性。

import用法
通过源文件相对位置导入，例子：

文件结构
├── Import.sol
└── Yeye.sol

通过文件相对位置import
import './Yeye.sol';

通过源文件网址导入网上的合约的全局符号，例子：
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';

通过npm的目录导入，例子：
import '@openzeppelin/contracts/access/Ownable.sol';

通过指定全局符号导入合约特定的全局符号，例子：
import {Yeye} from './Yeye.sol';

引用(import)在代码中的位置为：在声明版本号之后，在其余代码之前。

测试导入结果
我们可以用下面这段代码测试是否成功导入了外部源代码：
*/

// 通过文件相对位置import
import './MyContract.sol';
// 通过`全局符号`导入特定的合约
import {Yeye} from './MyContract.sol';
// 通过网址引用
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol';
// 引用OpenZeppelin合约
import '@openzeppelin/contracts/access/Ownable.sol';

contract Import{
    // 成功导入Address库
    using Address for address;
    // 声明yeye变量
    Yeye yeye = new Yeye();

    // 测试是否能调用yeye的函数
    function test() public {
        yeye.pop();
    }
} 