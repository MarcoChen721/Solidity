// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract Base{
    string public name = "Base";
    function getAlias() public virtual pure returns(string memory);
}

contract BaseImpl is Base{
    function getAlias() public pure override returns(string memory){
        return "BaseImpl";
        }
}