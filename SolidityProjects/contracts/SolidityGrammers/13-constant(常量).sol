// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Constants{


// constant常量和immutable不变量
// constant:constant变量必须在声明的时候初始化，之后再也不能改变。尝试改变的话，编译不通过。
// 注意: 只有数值变量可以声明constant和immutable；string和bytes可以声明为constant，但不能为immutable。

    // constant变量必须在声明的时候初始化，之后不能改变
    uint256 public constant NUM1 = 10; // 消耗gas:347
    uint256 public num1 = 10;// 消耗gas:2447
    string public constant STRING = 'HelloWeb3';
    bytes public constant BYTES = 'WTF'; // 0x575446
    address public constant ADDRESS = 0xF99A2948854F765A6D1343C270f2de8d702B188F;

// immutable变量可以在声明时或构造函数中初始化，因此更加灵活。在Solidity v8.0.21以后，immutable变量不需要显式初始化。
// 反之，则需要显式初始化。 若immutable变量既在声明时初始化，又在constructor中初始化，会使用constructor初始化的值。

    // immutable变量可以在constructor里初始化，之后不能改变
    uint256 public immutable NUM2 = 9999999;
    address public immutable ADDRESS1;
    uint256 public immutable BLOCK;
    uint256 public immutable TEST;

//  你可以使用全局变量例如address(this)，block.number 或者自定义的函数给immutable变量初始化。
// 在下面这个例子，我们利用了test()函数给IMMUTABLE_TEST初始化为9：

    // 利用constructor初始化immutable变量，因此可以利用
    constructor(){
        ADDRESS1 = address(this);
        // NUM2 = 9;
        NUM2 =  block.number;
        TEST = test();
    }

    function test() public pure returns(uint256) {
        uint256 what = 999;
        return(what);
        
    }

}
// 注意:
//  1-部署好合约之后，通过remix上的getter函数，能获取到constant和immutable变量初始化好的值。
//  2-constant变量初始化之后，尝试改变它的值，会编译不通过并抛出TypeError: Cannot assign to a constant variable.的错误。
//  3-immutable变量初始化之后，尝试改变它的值，会编译不通过并抛出TypeError: Cannot assign to a variable that is declared immutable.的错误。