// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract receiveETH{

/*
Solidity支持两种特殊的回调函数，receive()和fallback()，他们主要在两种情况下被使用：

1-接收ETH
2-处理合约中不存在的函数调用（代理合约`proxy contract`）

注意：在Solidity 0.6.x版本之前，语法上只有 fallback() 函数，用来接收用户发送的ETH时调用以及在被调用函数签名没有匹配到时，
来调用。0.6版本之后，Solidity才将 fallback() 函数拆分成 receive() 和 fallback() 两个函数。

1.接收ETH函数 receive
receive()函数是在合约收到ETH转账时被调用的函数。
一个合约最多有一个receive()函数，声明方式与一般函数不一样，不需要function关键字：`receive() external payable {}`
receive()函数不能有任何的参数，不能返回任何值，必须包含external和payable。

当合约接收ETH的时候，receive()会被触发。receive()最好不要执行太多的逻辑因为如果别人用send和transfer方法发送ETH的话，gas会限制在2300，
receive()太复杂可能会触发Out of Gas报错；如果用call就可以自定义gas执行更复杂的逻辑（这三种发送ETH的方法我们之后会讲到）。


2.回退函数 fallback
fallback()函数会在调用合约不存在的函数时被触发。可用于接收ETH，也可以用于代理合约proxy contract。
fallback()声明时不需要function关键字，必须由external修饰，一般也会用payable修饰，用于接收ETH:`fallback() external payable {}`

*/

// 我们可以在receive()里发送一个event，例如:

    event receivedCalled(address _from, uint256 _value); // 定义事件
    event fallbackCalled(address Sender, uint Value, bytes Data);

    receive() external payable{
        emit receivedCalled(msg.sender, msg.value);  // 接收ETH时释放Received事件
    }

    fallback() external payable{
        emit fallbackCalled(msg.sender, msg.value, msg.data); // 定义一个fallback()函数，被触发时候会释放fallbackCalled事件，并输出msg.sender，msg.value和msg.data:
        // 在fallback()函数中，我们可以通过msg.data来获取发送fallback()函数的原始数据，
        // 如果fallback()函数被调用时，没有匹配到任何函数，那么原始数据会被保存在msg.data中。
    }


    /*
    有些恶意合约，会在receive() 函数（老版本的话，就是 fallback() 函数）嵌入恶意消耗gas的内容或者使得执行故意失败的代码，
    导致一些包含退款和转账逻辑的合约不能正常工作，因此写包含退款等逻辑的合约时候，一定要注意这种情况。
    
   
    receive和fallback的区别
    receive和fallback都能够用于接收ETH，他们触发的规则如下:

        触发fallback() 还是 receive()?
                接收ETH
                    |
                msg.data是空？
                    /  \
                是    否
                /      \
        receive()存在?   fallback()
            / \
          是   否
         /      \
    receive()   fallback()

    结论：
        简单来说，合约接收ETH时，msg.data为空且存在receive()时，会触发receive()；msg.data不为空或不存在receive()时，
        会触发fallback()，此时fallback()必须为payable。receive()和payable fallback()均不存在的时候，向合约直接发送
        ETH将会报错（你仍可以通过带有payable的函数向合约发送ETH）。
    */

}