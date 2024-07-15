// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


/* 
Solidity中的继承（inheritance），包括简单继承，多重继承，以及修饰器（Modifier）和构造函数（Constructor）的继承。
继承
继承是面向对象编程很重要的组成部分，可以显著减少重复代码。如果把合约看作是对象的话，Solidity也是面向对象的编程，也支持继承。

规则:
    virtual: 父合约中的函数，如果希望子合约重写，需要加上virtual关键字。
    override：子合约重写了父合约中的函数，需要加上override关键字。

注意：用override修饰public变量，会重写与变量同名的getter函数，例如：
*/

// mapping (address => uint256) public override balanceOf;

/*
1-简单继承
步骤1：我们先写一个简单的爷爷合约Yeye，里面包含1个Log事件和3个function:
 hip(), pop(), yeye()，输出都是”Yeye”
*/

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

/*
步骤2：我们再定义一个爸爸合约Baba，让他继承Yeye合约，语法就是contract Baba is Yeye，非常直观。
在Baba合约里，我们重写一下hip()和pop()这两个函数，加上override关键字，
并将他们的输出改为”Baba”；并且加一个新的函数baba，输出也是”Baba”。
*/

contract Baba is Yeye{

    // 继承两个function: hip()和pop()，输出改为Baba。   
    function hip() public virtual override{
        emit log("Baba");
    }

    function pop() public virtual override{
        emit log("Baba");
    }

    function baba() public virtual{
        emit log("Baba");
    }
        
}


/*
2-多重继承
Solidity的合约可以继承多个合约。规则：
继承时要按辈分 最高到最低 的顺序排。比如我们写一个Erzi合约，继承Yeye合约和Baba合约，那么就要写成contract Erzi is Yeye, Baba，而不能写成contract Erzi is Baba, Yeye，不然就会报错。
如果某一个函数在多个继承的合约里都存在，比如例子中的hip()和pop()，在子合约里必须重写，不然会报错。
重写在多个父合约中都重名的函数时，override关键字后面要加上所有父合约名字，例如override(Yeye, Baba)。
*/

contract Erzi is Yeye, Baba{

    function hip() public virtual override(Yeye, Baba){
        emit log("Erzi");
    }

    function pop() public virtual override(Yeye, Baba){
        emit log("Erzi");
    }

    /* 
    5-调用父合约的函数
    子合约有两种方式调用父合约的函数，直接调用和利用super关键字。

    5-1.直接调用：子合约可以直接用父合约名.函数名()的方式来调用父合约函数，例如Yeye.pop()
    */
    function callParent() public{
        Yeye.pop();
    }

    /*
    5-2.super关键字：子合约可以利用super.函数名()来调用最近的父合约函数。
    Solidity继承关系按声明时从右到左的顺序是：contract Erzi is Yeye, Baba，
    那么Baba是最近的父合约，super.pop()将调用Baba.pop()而不是Yeye.pop()：
    */
    function callParentSuper() public{        
        super.pop(); // 将调用最近的父合约函数，Baba.pop()
    }
}


/*
3-修饰器的继承
Solidity中的修饰器（Modifier）同样可以继承，用法与函数继承类似，在相应的地方加virtual和override关键字即可。
*/

contract Base1{
    modifier exactDivideBy2And3(uint256 _a) virtual{
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}

contract Identifier is Base1{
    // 计算一个数分别被2除和被3除的值，但是传入的参数必须是2和3的倍数
    function getExactDivideBy2And3(uint256 _dividend) public exactDivideBy2And3(_dividend) pure returns(uint256,uint256){
        return  getExactDivideBy2And3WithoutModifier(_dividend);
    }

     //计算一个数分别被2除和被3除的值
     function getExactDivideBy2And3WithoutModifier(uint256 _dividend) public pure returns(uint256, uint256){
        uint256 div2 = _dividend / 2;
        uint256 div3 = _dividend / 3;
        return (div2, div3);
    }


// Identifier合约可以直接在代码中使用父合约中的exactDividedBy2And3修饰器，也可以利用override关键字重写修饰器：

    /*
    重写Modifier: 不重写时，输入9调用getExactDividedBy2And3，会revert，因为无法通过检查
    删掉下面三行注释重写Modifier，这时候输入9调用getExactDividedBy2And3， 会调用成功
    */
   
    modifier exactDivideBy2And3(uint256 _a) virtual override{
        _;
        require(_a % 2 == 0 && _a % 3 == 0);
        }
}

/* 
4-构造函数的继承
子合约有两种方法继承父合约的构造函数。
举个简单的例子，父合约A里面有一个状态变量a，并由构造函数的参数来确定:
*/

// 构造函数的继承
abstract contract A {

    uint256 public a;
    constructor(uint256 _a) {
        a = _a;    
    }
}

// 4-1.在继承时声明父构造函数的参数，例如：contract B is A(1)
contract B is A(1){

}

// 4-2.在子合约的构造函数中声明构造函数的参数，例如：
contract C is A{
    constructor(uint256 _c) A(_c * _c){

    }
}


/*
 6-钻石继承
在面向对象编程中，钻石继承（菱形继承）指一个派生类同时有两个或两个以上的基类。
在多重+菱形继承链条上使用super关键字时，需要注意的是使用super会调用继承链条上的每一个合约的相关函数，
而不是只调用最近的父合约。我们先写一个合约God，再写Adam和Eve两个合约继承God合约，
最后让创建合约people继承自Adam和Eve，每个合约都有foo和bar两个函数。

继承树：
  God
 /  \
Adam Eve
 \  /
people

*/

contract God{
    event log(string message);

    function foo() public virtual{
        emit log("God.foo called");
    }

    function bar() public virtual{
        emit log("God.bar called");
    }
}

contract Adam is God{

    function foo() public virtual override{
        emit log("Adam.foo called");
        super.foo();
    }

    function bar() public virtual override{
        emit log("Adam.bar called");
        super.bar();
    }
}

contract Eve is God{

    function foo() public virtual override{
        emit log("Eve.foo called");
        super.foo();
    }

    function bar() public virtual override{
        emit log("Eve.bar called");
        super.bar();
    }
}

contract People is Adam,Eve{

    function foo() public override(Adam,Eve){
        super.foo();
    }

    function bar() public override(Adam,Eve){
        super.bar();
    }
}

/*
注意：
    在这个例子中，调用合约people中的super.bar()会依次调用Eve、Adam，最后是God合约。
    虽然Eve、Adam都是God的子合约，但整个过程中God合约只会被调用一次。
    原因是Solidity借鉴了Python的方式，强制一个由基类构成的DAG（有向无环图）使其保证一个特定的顺序。
*/

