//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MyERC20 {
    uint256 public _totalSupply;
    string public _symbol;
    string public _name;

    mapping(address => uint256) _balances;
    mapping(address => mapping(address => uint)) _allowed;

    constructor(
        string memory name, 
        string memory symbol
    ) {
        _name = name;
        _symbol = symbol;
        _totalSupply = 0;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "ERC20: to address is not valid");
        require(amount > 0, "ERC20: amount is not valid");

        _totalSupply += amount;
        _balances[to] += amount;
    }

    function _burn(address from, uint256 amount) internal {
        require(from != address(0), "ERC20: from address is not valid");
        require(_balances[from] >= amount, "ERC20: insufficient balance");

        _balances[from] -= amount;
        _totalSupply -= amount;
    }

    function _transfer(address from, address to, uint tokens) internal returns (bool success) {
        require(_balances[from] >= tokens);
        require(_allowed[from][msg.sender] >= tokens);

        _balances[from] = _balances[from] - tokens;
        _allowed[from][msg.sender] = _allowed[from][msg.sender] - tokens;
        _balances[to] = _balances[to] + tokens;
        return true;
    }
}