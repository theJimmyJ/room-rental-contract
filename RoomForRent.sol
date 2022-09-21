// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

import "./RoomOwnable.sol";

contract Room is RoomOwnable {

    enum RoomStatus {VACANT, OCCUPIED}
    RoomStatus public currentStatus;

    // event declaration for occupation
    event Occupy(address _occupant, uint _value);

    // initially set room the room to vacant
    constructor() {
        currentStatus = RoomStatus.VACANT;
    }

    // modifier to make sure that the room is vacant
    modifier checkVacancy {
        require(currentStatus == RoomStatus.VACANT, "Room is currently occupied.");
        _;
    }

    // modifier to make sure at least the minimum ammount is provided for rental
    modifier checkCost(uint _amount) {
        require(msg.value >= _amount, "Not enough ether provided");
        _;
    }

    // function to call when room is to be rented
    function rentRoom() payable external checkVacancy checkCost(1 ether) {
        currentStatus = RoomStatus.OCCUPIED; // changes status of room to OCCUPIED  
        owner.transfer(msg.value); // sends payment
        emit Occupy(msg.sender, msg.value); // emit for the Occupy event
    }

    // function to make the room available again
    function markAvailable() external checkOwnership {
        currentStatus = RoomStatus.VACANT;
    }

}