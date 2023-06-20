**Issue category**
High as there is a potential for reentrancy
and Mathematical overflow


**IIssue title Write the title for the issue**I
There is a potential for caller to interact with the Game Contract
and drain finds and also due to Mathematical overflow, lead to a very high balance


**IWhere Where the issue is found**I
Call back function receiveItem that Game contract calls on buying Item.



**IImpact What is the negative impact if the issue is present**I
Loss of funds.

**IDescription Describe the issue in detail**I
The call back function of Player opens a window for manipulation via reentrancy.

a) Withdraw funds:
The issue is in the buyItem where the Game.buyItem is calling Player.receiveItem().
The contract that implements Player can hold a reference to Game contract and 
when the call for receiveItem is made, inside the receiveItem implementation=,
since the msg.sender was received as parameter,

the call to withdraw amount from Game contract can be made on behalf of the msg.sender.

b) Arthematic overflow:
since the balance of the account will be 0,when the below line is executed

 balances[msg.sender] -= 0.00001 ether;
 
The balance for the msg.sender will set to a very high number. This way, the msg.sender
will be able to drain the funds in Game contract after this. 


**IRecommendations to fix Provide recommendations to fix this issue**I
Implement reentrancy guard.
Also, the check for balance before debiting the account as there is a external interaction
and such interaction might impact the state of contract. so, better to check before processing the
deduction of funds.

Move the below check right before the deduction of ether from msg.sender balances.
require(balances[msg.sender] > 0.00001 ether);


**IAdditional context Add any other context about the problem here.**I
When interacting with external contracts, add reentrancy guard.

**IComments by AuditOne AuditOne team can comment here**I

Note: Replicate the above for multiple findings with a line separation in same file
