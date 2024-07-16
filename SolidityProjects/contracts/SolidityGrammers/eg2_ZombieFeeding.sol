// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./eg1_ZombieFactory.sol";

// Create KittyInterface here
abstract contract KittyInterface{
        function getKitty(uint256 _id) external view virtual returns(
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

// 继承（Inheritance）
contract ZombieFeeding is ZombieFactory{

    // 1. 移除这一行:
    // address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // 2. 只声明变量:
    KittyInterface kittyContract;

     // 3. 增加 setKittyContractAddress 方法
    function setKittyContractAddress(address _address) external onlyOwner{
        kittyContract = KittyInterface(_address);
    }

    // 第6章: 僵尸冷却
    // 6-1. 在这里定义 `_triggerCooldown` 函数
    function _triggerCooldown(Zombie storage _zombie) internal{
        _zombie.readyTime = uint32(now + cooldownTime);
    }

    // 6-2. 在这里定义 `_isReady` 函数
    function _isReady(Zombie storage _zombie) internal view returns(bool){
        return (_zombie.readyTime <= now);

    }

    // 第7章: 公有函数和安全性
    // 7-1.使这个函数的可见性为 internal
    function feedAndMultiply(uint256 _zombieId,uint256 _targetDna,string memory _species) public{
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];

        // 7-2. 在这里为 `_isReady` 增加一个检查
        require(_isReady(myZombie));
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;

        if(keccak256(abi.encode(_species)) == keccak256("kitty")){
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("NoName", newDna);
        // 7-3. 调用 `_triggerCooldown`
        _triggerCooldown(myZombie);

    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna,"kitty");

        
    }

}