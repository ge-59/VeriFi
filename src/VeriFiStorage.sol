// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.25;

library VeriFiStorage {

    struct Layout {
        bytes32 MERKLE_ROOT;
    }

     bytes32 internal constant STORAGE_SLOT =
        keccak256('projects.contracts.storage.verifi');

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}