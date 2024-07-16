// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./ownable.sol";

contract ZombieFactory is Ownable {
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    // 僵尸DNA的位数
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10 ** dnaDigits;
    // 1. 在这里定义 `cooldownTime`
    uint cooldownTime = 1 days;

    struct Zombie {
        uint256 dna;
        string name;
        // 可以添加更多属性，如攻击力、防御力等
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;

    // 在这里映射
    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) ownerZombieCount;

    // 创建一个新的僵尸
    function _createZombie(string memory _name, uint256 _dna) internal {
        zombies.push(Zombie(_dna, _name,1,uint32(now + cooldownTime)));
        uint256 zombieId = zombies.length - 1;

        // 1-在得到新的僵尸 id 后，更新 zombieToOwner 映射，在 id 下面存入 msg.sender。
        // 2-为这个 msg.sender 名下的 ownerZombieCount 加 1。
        zombieToOwner[zombieId] = msg.sender;
        ownerZombieCount[msg.sender]++;

        emit NewZombie(zombieId, _name, _dna);
    }

    // 随机生成僵尸DNA
    function generateRandomDna(
        string memory _str
    ) private view returns (uint256) {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
        // 注意：这里使用了keccak256哈希算法，但你可以根据需要使用其他算法
    }

    function createRandomZombie(string memory _name) public {
        // 使用require 来确保这个函数只有在每个用户第一次调用它的时候执行，用以创建初始僵尸。
        require(ownerZombieCount[msg.sender] == 0); // 每个玩家只能创建一个僵尸
        
        uint256 randDna = generateRandomDna(_name);
        randDna = randDna - randDna % 100; // 确保僵尸的 DNA 至少有一个数字
        _createZombie(_name, randDna);
    }

}

