//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MyAccessControl {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }

    mapping(bytes32 => RoleData) private _roles;

    function _setupRole(bytes32 role, address account) internal virtual {
        _roles[role].members[account] = true;
    }

    function hasRole(bytes32 role, address account) public view returns (bool)
    {
        return _roles[role].members[account];
    }

    function msgSender() public view returns (address){
        return msg.sender;
    }
}