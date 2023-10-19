// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @title an implementation of ERC20 fungible token contract.
/// @author dchouhan-in@github.com
/// @notice creates contract for "DIV" token.
/// @dev by default it mints all the tokens to the deployer address.
contract ERC20Token {
    string _name = "DIVYANSHU COIN";
    string _symbol = "DIV";
    uint96 _totalSupply = 10000 * _decimals;
    uint8 _decimals = 6;

    mapping(address => mapping(address => uint96)) _allowance;

    mapping(address => uint96) public _balanceOf;

    /// @dev event emmited when a token is transfered
    /// @param _from Address from whom token is transfered.
    /// @param _to Address to which token is transfered.
    /// @param _value Value of token to be transfered.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /// @dev event emmited when someone approves else of their tokens
    /// @param _owner Owner of the tokens
    /// @param _spender Aproved address
    /// @param _value Value of token to be Approved!
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    /// @dev constructor currently consist of minting logic.
    constructor() {
        _mint(msg.sender, _totalSupply);
    }

    /// @dev Mints the tokens to an address.
    /// @param _to address to mint tokens to
    /// @param _value ammount of tokens
    function _mint(address _to, uint96 _value) private {
        require(_totalSupply >= _value, "insufficient supply!");
        _balanceOf[_to] += _value;
        _totalSupply -= _value;
    }

    /// @dev Name of token
    /// @return name string
    function name() public view returns (string memory) {
        return _name;
    }

    /// @dev Symbol of token
    /// @return symbol string
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /// @dev Allowed decimal places
    /// @return decimals uint8
    function decimals() public view returns (uint8) {
        return _decimals;
    }

    /// @dev Total Supply Available
    /// @return totalSupply total supply currently available
    function totalSupply() public view returns (uint96) {
        return _totalSupply;
    }

    /// @dev Query balance of specific address
    /// @return balance balance of the _owner
    /// @param _owner address, to query balance of
    function balanceOf(address _owner) public view returns (uint96 balance) {
        return _balanceOf[_owner];
    }

    /// @dev Transfer tokens to an address
    /// @return success are the tokens successfuly transfered!
    /// @param _to address, to transfer token to
    /// @param _value amount of tokens to transfer.
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

    /// @dev Allows approved addresses to transfer funds in behalf
    /// @return success are the tokens successfuly transfered!
    /// @param _to address, to transfer token to
    /// @param _value amount of tokens to transfer.
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

    /// @dev approve spender to let spend in behalf
    /// @return success are the tokens successfuly transfered!
    /// @param _spender address, of the spender.
    /// @param _value amount of tokens to transfer.
    function approve(
        address _spender,
        uint96 _value
    ) public returns (bool success) {
        _allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /// @dev query allowance
    /// @return remaining remaing allowed tokens
    /// @param _spender address, of the spender.
    /// @param _owner address of the owner.
    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint96 remaining) {
        return _allowance[_owner][_spender];
    }
}
