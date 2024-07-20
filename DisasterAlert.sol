// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DisasterAlert {
    address public admin;
    mapping(uint256 => string) public alerts;
    uint256 public alertCount;

    event AlertCreated(uint256 indexed alertId, string message);

    constructor() {
        admin = msg.sender;
        alertCount = 0;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can execute this.");
        _;
    }

    function createAlert(string memory _message) public onlyAdmin {
        alertCount++;
        alerts[alertCount] = _message;
        emit AlertCreated(alertCount, _message);
    }

    function getAlert(uint256 _alertId) public view returns (string memory) {
        return alerts[_alertId];
    }
}
