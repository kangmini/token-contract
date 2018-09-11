pragma solidity ^0.4.23;

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract MewToken is StandardToken {

    uint public INITIAL_SUPPLY = 10000000000;
    string public name = 'MewToken';
    string public symbol = 'MEW';
    uint8 public decimals = 18;
    address owner;
    bool public released = false;

    constructor() public {
        totalSupply_ = INITIAL_SUPPLY * 10 ** uint(decimals);
        balances[msg.sender] = INITIAL_SUPPLY;
        owner = msg.sender;
    }

    function release() public {
        require(owner == msg.sender);
        require(!released);
        released = true;
    }


    modifier onlyReleased() {
        require(released);
        _;
    }

    function transfer(address to, uint256 value) public onlyReleased returns (bool) {
        super.transfer(to, value);
    }
    function allowance(address mowner, address spender) public onlyReleased view returns (uint256) {
        super.allowance(mowner,spender);
    }
    function transferFrom(address from, address to, uint256 value) public onlyReleased returns (bool) {
        super.transferFrom(from, to, value);
    }
    function approve(address spender, uint256 value) public onlyReleased returns (bool) {
        super.approve(spender,value);
    }
}
