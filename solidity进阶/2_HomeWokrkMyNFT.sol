// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 引入 OpenZeppelin 的 ERC721 和工具库
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
is                                                  MyNFT 继承了 ERC721URIStorage
using ... for ...                                   绑定库方法到某个数据类型上
string memory                                       表示存储在内存中的字符串类型（不是永久storeage）
_mint()                 作用：设置 NFT 元数据链接       说明：将 tokenId 与一个 IPFS 链接绑定
_tokenIds.increment()   作用：增加计数器               说明：通过 Counters 库实现自动 tokenId 递增
_tokenIds.current()	    作用：获取当前 tokenId         说明：获取当前 NFT 的编号（用于铸造）
_tokenIds.increment();         // 计数器加1
_tokenIds.current();           // 获取当前数字
_setTokenURI()         设置 NFT 元数据链接             将 tokenId 与一个 IPFS 链接绑定
**/

contract MyNFT is ERC721URIStorage {
    // 我想给 Counters.Counter 这个结构绑定一些工具函数，比如 .increment() 和 .current()
    using Counters for Counters.Counter;
    // 声明变量创建了_tokenIds的计时器，类型时 Counters.Counter，并设计为私有 private
    Counters.Counter private _tokenIds;

    constructor() ERC721("MyNFT", "MNFT") {
        // 合约初始化时，设置名称与符号
    }
    // mint NFT 的函数，接收用户地址和 tokenURI（图片的元数据链接）
    function mintNFT(address recipient, string memory tokenURI) public returns (uint256) {
        _tokenIds.increment(); // 计数器递增，生成新的 tokenId
        uint256 newItemId = _tokenIds.current();

        _mint(recipient, newItemId);        // 铸造 NFT 给指定地址
        _setTokenURI(newItemId, tokenURI); // 设置 NFT 对应的 metadata 链接

        return newItemId;
    }
}