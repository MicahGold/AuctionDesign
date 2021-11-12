// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.9;
contract Sender {
    uint256 public amount;
    address payable public sender;
    address payable public receiver;
    constructor( address payable addr) payable{
        amount = msg.value;
        addr.transfer(msg.value);
        receiver = addr;
        sender = payable(msg.sender);
    }
    function getReceiver() public view returns(address payable){
        return receiver;
    }
    function getAmount() public view returns(uint256){
        return amount;
    }
    function getAddress() public view returns(address payable){
        return sender;
    }

}