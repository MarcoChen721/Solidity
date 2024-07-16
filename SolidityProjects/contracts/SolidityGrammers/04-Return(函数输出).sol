// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Return{
    // 返回值：return 和 returns
    // returns：跟在函数名后面，用于声明返回的变量类型及变量名。
    // return：用于函数主体中，返回指定的变量。

    // 返回多个变量
    function returnMultiple() public pure returns(uint256,bool,uint256[3] memory){
        return (1,true, [uint256(1),2,3]);
    }

    // 命名式返回
    function returnNamed() public pure returns(uint256 num,bool _bool,uint256[3] memory _array){
        num = 1;
        _bool = false;
        _array = [uint256(1),2,3];
    }

    function returnNamed2() public pure returns(uint256 num,bool _bool,uint256[3] memory _array){
        return(1,true,[uint256(1),2,5]);
    }

    // 解构式赋值
    function readReturn() public pure{
        // 读取全部返回值
        uint256 num;
        bool _bool;
        uint256[3] memory _array;
        (num,_bool,_array) = returnNamed();
        
        // 读取部分返回值
        (,_bool,) = returnNamed();
    }

}