**Issue category**
High

**Issue title**
Low-level call return value not checked in `withdraw()`

**Where**
https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L16

**Impact**
`withdraw()` does not guarantee that users receive the amount of ETH they specified.

**Description**
In `withdraw()`, `msg.sender.call.value(_amount)("");` does not check the return value of the low-level call, therefore the tx won't revert even if the low-level call fails. In such case, the user's balance (`balances[msg.sender]`) is deducted but the user does not receive ETH, so the user's balance will be lost.

**Recommendations to fix**
Change to:

```solidity
    function withdrw(uint _amount) public {
        require(balances[msg.sender] > _amount);
        balances[msg.sender] -= _amount;
        (bool success, ) = msg.sender.call.value(_amount)("");
        require(success, "low-level call failed");
    }
```

**Additional context**
None.

**Comments by AuditOne**
AuditOne team can comment here

------

**Issue category**
Medium

**Issue title**
Reentrancy in `buyItem()` comming from unsafe external call

**Where**
https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L27-L28

**Impact**
Player may receive lots of items with only 0.00001 ETH deposit, although only 1 of these items will be activated.

**Description**
`buyItem()` does not CEI pattern:

```solidity
        player.receiveItem(item); // Interaction
        balances[msg.sender] -= 0.00001 ether; // Effect
```

The external call `player.receiveItem(item);` is unsafe: an attacker can implement reentrancy attack in this call. For example:

- `player.receiveItem(item);` triggers attacker's implementation of `receiveItem()`.
- `receiveItem()` reenters into `buyItem()`. At this moment `balances[msg.sender]` is not deducted yet.
- `player.receiveItem(item);` is triggered again.
- The above steps can be repeated for many many times by the attacker

The impact of this issue is medium because only the very last item will be activated. Although not activated, the attacker could receive those item that he/she does not deserve. 

**Recommendations to fix**
Change the code to:

```solidity
        balances[msg.sender] -= 0.00001 ether;
        player.receiveItem(item);
```

**Additional context**
None.

**Comments by AuditOne**
AuditOne team can comment here

------

**Issue category**
Low

**Issue title**
Integer overflow in `deposit()`

**Where**
https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L2

https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L10

**Impact**
Solidity compiler version 0.6 does not provide integer overflow/underflow protection. The contract was written without using the SafeMath library, therefore integer overflow/underflow could occur.

**Description**
In `deposit()`, `balances[msg.sender] += msg.value;` could overflow (but very unlikely). If overflow, user's balance would be lost.

**Recommendations to fix**
Use `pragma solidity 0.8.17`.

**Additional context**
None.

**Comments by AuditOne**
AuditOne team can comment here

------

**Issue category**
Informational

**Issue title**
All `public` functions can be set to `external` to save gas

**Where**
https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L9

https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L13

https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L19

https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L23

**Impact**
Functions that are not called within the contract can be set as `external` to save gas.

**Description**
`external` functions are cheaper than `public` ones because `public` functions copy function arguments into the memory whereas `external` functions can read directly from calldata.

Check this stackexchange answer for detailed explanation: https://ethereum.stackexchange.com/questions/19380/external-vs-public-best-practices

**Recommendations to fix**
Set all functions in this contract to `external`.

**Additional context**
None.

**Comments by AuditOne**
AuditOne team can comment here
