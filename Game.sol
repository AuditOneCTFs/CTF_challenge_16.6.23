// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./Item.sol";

interface Player {function receiveItem(Item) external;}
contract Game {
    mapping(address => uint) balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdrw(uint _amount) public {
        require(balances[msg.sender] > _amount);
        balances[msg.sender] -= _amount;
        msg.sender.call.value(_amount)("");
    }

    function getBalance(address a) public returns(uint) {
        return balances[a];
    }

    function buyItem() public {
        require(balances[msg.sender] > 0.00001 ether);
        Item item = new Item();
        Player player = Player(msg.sender);
        player.receiveItem(item);
        balances[msg.sender] -= 0.00001 ether;
        //Item is activated after the paytment is made
        //Before activation, the item is worthless;
        item.activate(); //function activate() onlyOwner
    }
}
