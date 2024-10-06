// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

/// @title VeriFiStorage
/// @dev Storage library to leverage unstructured storage pattern for VeriFi contract
library VeriFiStorage {

    /// @dev Struct containing all state for the VeriFi contract
    struct Layout {
        /// @dev The Merkle root used for verification
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