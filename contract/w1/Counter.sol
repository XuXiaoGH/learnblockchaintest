/**
 * Counter
 * network: bsc test
 * txhash: 0xc5b2893c896a50a0ab899d409888b371733e87dc683e3950e455f1f7074f26bb
 */

pragma solidity ^0.8.0;

contract Counter {
  uint public counter;

  constructor() {
    counter = 0;
  }

  function addCount(uint num) public {
    counter = counter + num;
  }
}
