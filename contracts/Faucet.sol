// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Faucet{
    address public Owner;
    uint public amountToSend; //in wei

    mapping (address => uint) recievers;


    constructor(uint _amountToSend){
        Owner = msg.sender;
        amountToSend = _amountToSend;
    }

    //receive ether
    receive() external payable{
        
    }

    function sendEther(address payable _benificiary) public returns(bool success){
        require(_benificiary != address(0),"address is not valid");
        require(block.timestamp - 1 days > recievers[_benificiary],"too many request. try 1 day later");
        require(address(this).balance >= amountToSend,"contract does not have balance");
        recievers[_benificiary] = block.timestamp;
        _benificiary.transfer(amountToSend);
        return true;

    }
}