 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SavingsSmartContract {
    address public owner;
    mapping(address => uint256) public balances;

    event Deposit(address account, uint256 amount);
    event Withdrawal(address account, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    
constructo() [
owner = msg.sender;
    }


function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(amount <= balances[msg.sender], "Insufficient balance");

        // Ensure the withdrawal does not exceed the contract's balance
        require(amount <= address(this).balance, "Contract balance is not sufficient");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
 function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdrawAll() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No funds to withdraw");

        // Ensure the withdrawal does not exceed the contract's balance
        require(amount <= address(this).balance, "Contract balance is not sufficient");

        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

   // Only the owner can withdraw the entire contract balance
    function withdrawContractBalance() public onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds to withdraw");
        payable(owner).transfer(contractBalance);
        emit Withdrawal(owner, contractBalance);
    }
}
 
    
        
