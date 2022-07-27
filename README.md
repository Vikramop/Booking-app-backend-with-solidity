# Booking an appointment

A simple booking appointments back-end with solidity.

## Environment

We can execute the code in our local environment using hardhat, But it's much convenient
and eaiser to do on [Remix](https://remix-project.org/) ide.

## Code Break-down

Starting with license and version of solidity.

```solidity
// SPDX-License-Identifier: MIT

  pragma solidity ^0.8.7;
```

Then creating a contract named MyHos.

```solidity
 contract MyHos {
}
```

Now initializing the address to the owner with public state variable, So there more number of state variables but mainly we use public and private the most. The public variable can be accessed by all the function and private does not provide that leniency. Learn more on [state variables](https://docs.soliditylang.org/en/v0.8.15/structure-of-a-contract.html#state-variables)

```solidity
 address public owner;
```

Now as we know more people would book an appointment so we have to map there wallet address to the number of appointments they have booked. This would also help them to know that how many appointments they have booked

```solidity
 mapping (address => uint) public TotalAppointments;
```

Now let's add a constructor, Constructor is a type of function that runs only one time the code is deployed. In this we say that the owner of the contract is the one who deploys it. And let's initially assume that the total appointments for this contract is 5.

```solidity
constructor() {
        owner = msg.sender;
        TotalAppointments[address(this)]= 5;
      }
```

And now let's consider the functions. The first fucnction is to get the remaining appointments left.

```solidity
function getremainingAppointments() public view returns (uint) {
        return TotalAppointments[address(this)];
      }
```

The second function is for the owner of the contact only, if all the appointments are over then then owner can update it. It uses the error handling that is [require](https://docs.soliditylang.org/en/v0.8.15/control-structures.html#panic-via-assert-and-error-via-require) it throws an error or revert the trasaction if condition is not met.

```solidity
function UpdateAppointments(uint amount) public {
        require(msg.sender == owner, "Only Hospital can update Appointments.");
         TotalAppointments[address(this)] +=amount;
      }
```

Now mapping the people with the boolean that is if people have booked then it shows true else it shows false. This is used further to prevent the same user to book multiple times.

```solidity
 mapping (address => bool) UserBookings;
```

Now it's time for the function to actually book an appointment, since the function requires to get ether/money it should be payable and next it has 2 require one for the user to pay enough money to the contract and another for the user to not book the appointments repeatdly. And after the booking the function getremainingAppointments gets updated and user can also see their number of appointments they have made.

```solidity
function BookAppointment(uint amount) public payable {

        require(msg.value >=  amount * 1 ether , "you must pay enough to make an appointment");
        require(!UserBookings[msg.sender] ,"You have alredy booked an appointment");
        TotalAppointments[address(this)] -= amount;
        TotalAppointments[msg.sender] += amount;
        UserBookings[msg.sender] = true;

      }
```

## Full code

```solidity
// SPDX-License-Identifier: MIT

  pragma solidity ^0.8.7;

  contract MyHos {
      address public owner;
      mapping (address => uint) public TotalAppointments;

      constructor() {
        owner = msg.sender;
        TotalAppointments[address(this)]= 5;
      }

      function getremainingAppointments() public view returns (uint) {
        return TotalAppointments[address(this)];
      }

      function UpdateAppointments(uint amount) public {
        require(msg.sender == owner, "Only Hospital can update Appointments.");
         TotalAppointments[address(this)] +=amount;
      }

      mapping (address => bool) UserBookings;

       function BookAppointment(uint amount) public payable {

        require(msg.value >=  amount * 1 ether , "you must pay enough to make an appointment");
        require(!UserBookings[msg.sender] ,"You have alredy booked an appointment");
        TotalAppointments[address(this)] -= amount;
        TotalAppointments[msg.sender] += amount;
        UserBookings[msg.sender] = true;

      }



  }
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
