// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ERC20 {
  function transferFrom(address from, address to, uint256 value) external returns (bool ok);
}

import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract NftExchange {

  struct Order {
    address collection;
    uint256 tokenId;
    address maker;
    address currency;
    uint256 price;
  }

  mapping(address => mapping(uint256 => Order)) private orders;

// 实现转移数字货币
  function transferErc20(address tokenAddress, address from, address to, uint256 amount) public returns (bool ok) {
    ERC20 token = ERC20(tokenAddress);
    token.transferFrom(from, to, amount);
    return true;
  }

  // // 实现转移NFT
  function transferErc721(address nftAddress, address from, address to, uint256 tokenId) external {
    IERC721(nftAddress).safeTransferFrom(from, to, tokenId);
  }

  // 上架
  function makeOrder(address _collection, uint256 _tokenId, address currency, uint256 price) external {
    require(_collection != address(0), "collection address cannot be 0");
    require(_tokenId != 0, "tokenId cannot be 0");
    require(currency != address(0), "currency address cannot be 0");
    require(price != 0, "price cannot be 0");

    orders[_collection][_tokenId] = Order({
      collection: _collection,
      tokenId: _tokenId,
      maker: msg.sender,
      currency: currency,
      price: price
    });
  }

  // 购买
  function buy(address _collection, uint256 _tokenId) external {
    // 先取出单子
    Order storage order = orders[_collection][_tokenId];
    // 进行扣款
    this.transferErc20(order.currency, msg.sender, order.maker, order.price);
    // 进行转移 NFT
    this.transferErc721(order.collection, order.maker, msg.sender, order.tokenId);
  }

  function getOrderPrice(address _collection, uint256 _tokenId) public view returns (uint256) {
    require(_collection != address(0), "collection address cannot be 0");
    require(_tokenId != 0, "tokenId cannot be 0");
    return orders[_collection][_tokenId].price;
  }

}