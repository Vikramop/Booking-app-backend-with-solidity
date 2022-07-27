// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract MyHos {
    address public owner;
    mapping(address => uint) public TotalAppointments;

    constructor() {
        owner = msg.sender;
        TotalAppointments[address(this)] = 5;
    }

    function getremainingAppointments() public view returns (uint) {
        return TotalAppointments[address(this)];
    }

    function UpdateAppointments(uint amount) public {
        require(msg.sender == owner, "Only Hospital can update Appointments.");
        TotalAppointments[address(this)] += amount;
    }

    mapping(address => bool) UserBookings;

    function BookAppointment(uint amount) public payable {
        require(
            msg.value >= amount * 1 ether,
            "you must pay enough to make an appointment"
        );
        require(
            !UserBookings[msg.sender],
            "You have alredy booked an appointment"
        );
        TotalAppointments[address(this)] -= amount;
        TotalAppointments[msg.sender] += amount;
        UserBookings[msg.sender] = true;
    }
}
