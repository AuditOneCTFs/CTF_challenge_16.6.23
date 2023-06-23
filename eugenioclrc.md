
**Issue category**
HIGH

**Issue title**
Reentrancy on `buyItem` allows malicious user to underflow balances and steal all funds

**Where**
On the `buyItem` function;
[Game.sol#L27](https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L27)

**Impact**
User can reenter to function and underflow balances, stealing all funds, user can also get unlimited items using the same reentrancy.

**Description**
Malicious user have to craft a contract that leverage on `player.receiveItem` hook to reenter, then he could underflow the balance and widthdraw all contract funds or mint an infinite amount of items.

**Recommendations to fix**
Add reentrancy guard, and try to stick to the [CEI pattern](https://fravoll.github.io/solidity-patterns/checks_effects_interactions.html)

**Additional context**


**Comments by AuditOne**


---

**Issue category**
HIGH

**Issue title**
Cross reentrancy on `buyItem` and `withdrw`

**Where**
[Game.sol#L27](https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L27)
[Game.sol#L13](https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L13)


**Impact**
Malicious user can mint infinite items and steal all funds.

**Description**
User can `buyItem` and then `withdrw` all funds, performing a cross reentrancy, underflowing balances and being able to mint infinite items and steal all funds.


**Recommendations to fix**
Add reentrancy guard to `withdrw` and `buyItem`, and try to stick to the [CEI pattern](https://fravoll.github.io/solidity-patterns/checks_effects_interactions.html) on the `buyItem`

**Additional context**


**Comments by AuditOne**

---

**Issue category**
MED

**Issue title**
User ether dust can get stuck in the contract

**Where**
[GameGame.sol#L14](https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L14)


**Impact**
Users cant withdraw all funds, 1 wei for each user will get stuck


**Description**
Due this check `require(balances[msg.sender] > _amount);` users cant withdraw 100% of their funds.


**Recommendations to fix**
use `require(balances[msg.sender] >= _amount);` instead of `require(balances[msg.sender] > _amount);`

**Additional context**


**Comments by AuditOne**


---

**Issue category**
MED

**Issue title**
Price per item is `0.00001 ether` but users have to deposit more than `0.00001 ether`to buy one

**Where**
[GameGame.sol#L24](https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L24)


**Impact**
A users that wants to buy one item has to deposit more than the price of an item of `0.00001 ether`


**Description**
Due this check `require(balances[msg.sender] > 0.00001 ether)` hav to deposit more than `0.00001 ether` to buy one item


**Recommendations to fix**
use `require(balances[msg.sender] >= 0.00001 ether)` instead of `require(balances[msg.sender] > 0.00001 ether)`

**Additional context**


**Comments by AuditOne**

---

**Issue category**
QA

**Issue title**
Typo error on function name should be `withdraw` instead of `withdrw`

**Where**
[GameGame.sol#L13](https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#LL13C14-L13C21)


---

**Issue category**
QA

**Issue title**
Typo error on comment, should say `payment` instead of `paytment`

**Where**
[GameGame.sol#L29](https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L29)

---

**Issue category**
QA

**Issue title**
Set explicit visibility of `balances` state variable.

**Where**
[GameGame.sol#L7](https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L7)



---

**Issue category**
QA

**Issue title**
Use `uint256` instead of `uint`

---

**Issue category**
QA

**Issue title**
Use revert messages instead of empty reverts, example, instead of; 
`require(balances[msg.sender] > _amount);` use `require(balances[msg.sender] > _amount, "INSUFFICIENT AMOUNT");`

---

**Issue category**
QA

**Issue title**
All function methods can be declared as `external` instead of `public`, this will make you save gas.

---

**Issue category**
QA

**Issue title**
Avoid open prama and preffer new more mantain solidity versions, [Game.sol#L2](https://github.com/AuditoneCodebase/CTF_challenge_16.6.23/blob/b1478351fc0a8071b612547b54878a69456f4a29/Game.sol#L2)

---

**Issue category**
QA

**Issue title**
Add natspec to all functions to make clear to other devs whats going on, more on [natspec-format](https://docs.soliditylang.org/en/develop/natspec-format.html)