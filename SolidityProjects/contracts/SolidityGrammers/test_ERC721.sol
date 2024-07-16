// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// import "npm/@openzeppelin/contracts/token/ERC721";
// import "github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.0/contracts/drafts/Counters.sol";

// //全功能ERC721代币
// contract ERC721FullContract is ERC721Full {
//     using Counters for Counters.Counter;
//     Counters.Counter private _tokenIds; 

//     constructor(
//         string memory name, // 代币名称
//         string memory symbols, // 代币缩写
//         string memory baseURI // 代币元数据地址
//     )ERC721Full(name,symbols) public {
//         _setBaseURI(baseURI);
//     }

//     function mint(address user,string memory tokenURI) public returns(uint256) {
//         _tokenIds.increment();

//         uint256 newItemId = _tokenIds.current();
//         _mint(user,newItemId);
//         _setTokenURI(newItemId,tokenURI);

//         return newItemId;
//     }
// }