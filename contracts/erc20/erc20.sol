// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract ERC20Token {
    string _name = "DIVYANSHU COIN";
    string _symbol = "DIV";
    uint96 _totalSupply = 10000 * _decimals;
    uint8 _decimals = 6;

    mapping(address => mapping(address => uint96)) _allowance;

    mapping(address => uint96) public _balanceOf;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    constructor() {
        _mint(msg.sender, _totalSupply);
    }

    function _mint(address _to, uint96 _value) private {
        require(_totalSupply >= _value, "insufficient supply!");
        _balanceOf[_to] += _value;
        _totalSupply -= _value;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint96) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return _balanceOf[_owner];
    }

    function transfer(
        address _to,
        uint96 _value
    ) public returns (bool success) {
        require(balanceOf(_to) >= _value, "Insufficient Balance!");
        _balanceOf[_to] += _value;
        _balanceOf[msg.sender] -= _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint96 _value
    ) public returns (bool success) {
        require(
            msg.sender == _from,
            "sender address and from address must match!"
        );
        require(_value <= _allowance[_from][_to], "insufficient approval");
        _allowance[_from][_to] -= _value;
        _balanceOf[_from] -= _value;
        _balanceOf[_to] += _value;
        return true;
    }

    function approve(
        address _spender,
        uint96 _value
    ) public returns (bool success) {
        _allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint96 remaining) {
        return _allowance[_owner][_spender];
    }
}
