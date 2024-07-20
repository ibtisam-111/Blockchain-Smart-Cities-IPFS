// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RescueOperation {
    address public admin;
    mapping(uint256 => Rescue) public rescues;
    uint256 public rescueCount;

    struct Rescue {
        uint256 id;
        string location;
        string status;
        uint256 timestamp;
    }

    event RescueCreated(uint256 indexed rescueId, string location);
    event RescueUpdated(uint256 indexed rescueId, string status);

    constructor() {
        admin = msg.sender;
        rescueCount = 0;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can execute this.");
        _;
    }

    function createRescue(string memory _location) public onlyAdmin {
        rescueCount++;
        rescues[rescueCount] = Rescue(rescueCount, _location, "Pending", block.timestamp);
        emit RescueCreated(rescueCount, _location);
    }

    function updateRescueStatus(uint256 _rescueId, string memory _status) public onlyAdmin {
        rescues[_rescueId].status = _status;
        emit RescueUpdated(_rescueId, _status);
    }

    function getRescue(uint256 _rescueId) public view returns (Rescue memory) {
        return rescues[_rescueId];
    }
}
