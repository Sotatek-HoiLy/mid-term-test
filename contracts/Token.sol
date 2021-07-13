pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "./Action.sol";

contract Token is ERC20, AccessControl, Ownable, Action {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    constructor(
        string memory name,
        string memory symbol,
        address owner,
        address minterRole,
        address burnerRole,
        address adminRole
    ) ERC20(name, symbol) {
        _mint(owner, 0);
        _setupRole(MINTER_ROLE, minterRole);
        _setupRole(BURNER_ROLE, burnerRole);
        _setupRole(ADMIN_ROLE, adminRole);
    }

    modifier isMinter() {
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _;
    }

    modifier isBurner() {
        require(hasRole(BURNER_ROLE, msg.sender), "Caller is not a burner");
        _;
    }

    modifier isAdmin() {
        require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not a admin");
        _;
    }

    modifier isPauseTransfer() {
        require(!isPaused(), "Admin paused transfer transaction.");
        _;
    }

    function mint(address account, uint256 amount) public {
        uint256 totalSupply = totalSupply() + amount;
        require( totalSupply < 1000000000, "Tokens can not mint access capped at 1 billion supplies.");
        _mint(account, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function pauseTransfer() public isAdmin {
        setPause();
    }

    function unPauseTransfer() public isAdmin {
        setUnpause();
    }

    function transfer(address _address, uint256 amount) public override isPauseTransfer returns (bool) {
        _transfer(msg.sender, _address, amount);
        return true;
    }
}
