// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contract MyContract {
//     uint public myVariable;

//     constructor() {
//         myVariable = 100;
//     }
    
//     function setVariable(uint newValue) public {
//         myVariable = newValue;
//     }

//     function getVariable() public view returns (uint) {
//         return myVariable;
//     }
// }

contract Yeye{
    event log(string msg);

    function hip() public virtual{
        emit log("Yeye");
    }

    function pop() public virtual{
        emit log("Yeye");
    }

    function yeye() public virtual{
        emit log("Yeye");
    }
}

contract Baba is Yeye{

    function hip() public virtual override{
        emit log("Baba");
    }

    function pop() public virtual override{
        emit log("Baba");
    }

    function baba() public virtual {
        emit log("Baba");
    }
}

contract Erzi is Yeye,Baba{

    function hip() public virtual override(Yeye,Baba){
        emit log("Erzi");
    }

    function pop() public virtual override(Yeye,Baba){
        emit log("Erzi");
    }

    function callParent() public{
        Yeye.hip();
    }

    function callParentSuper() public{
        super.hip();
    }
}