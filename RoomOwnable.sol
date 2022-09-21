// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract RoomOwnable {

    address payable public owner;

    // declaring owner of the room for rent is who runs this contract
    constructor() {
        owner = msg.sender; 
    }

    // modifier to be used on function if we want only the owner to be able to run them
    modifier checkOwnership { 
        require (msg.sender == owner);
        _;
    }

}