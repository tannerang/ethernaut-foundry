// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

interface IEthernaut {
    function createLevelInstance(address) external payable;
    function submitLevelInstance(address payable) external;
}