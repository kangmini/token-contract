pragma solidity ^0.4.23;

import './MewToken.sol';
import './MewTokenWhitelist.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

contract MewTokenSale {

    using SafeMath for uint256;
    uint public constant EMMAS_PER_WEI = 10000000;
    uint public constant HARD_CAP = 500000000000000;
    MewToken public token;
    MewTokenWhitelist public whitelist;
    uint public emmasRaised;
    bool private closed;

    constructor (MewToken _token, MewTokenWhitelist _whitelist) public {
        require(_token != address(0));
        token = _token;
        whitelist = _whitelist;
    }

    function() external payable {
        require(!closed);
        require(msg.value != 0);
        require(whitelist.isRegistered(msg.sender));

        uint emmasToTransfer = msg.value.mul(EMMAS_PER_WEI);
        uint weisToRefund = 0;
        if (emmasRaised + emmasToTransfer > HARD_CAP) {
            emmasToTransfer = HARD_CAP - emmasRaised;
            weisToRefund = msg.value - emmasToTransfer.div(EMMAS_PER_WEI);
            closed = true;
        }
        emmasRaised = emmasRaised.add(emmasToTransfer);
        if (weisToRefund > 0) {
            msg.sender.transfer(weisToRefund);
        }

        token.transfer(msg.sender, emmasToTransfer);
    }
}