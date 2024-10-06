// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface IVeriFi {
    event MerkleRootUpdated(bytes32 newRoot);
    event ManagerAdded(address newManager);
    event ManagerRemoved(address manager);

    error Initialization_InvalidMerkleRoot();
    error UpdateMerkleRoot_InvalidMerkleRoot();
    error Initialization_InvalidAdminAddress();
    error AddManager_InvalidManagerAddress();
    error RemoveManager_InvalidManagerAddress();
    error AuthorizeUpgrade_InvalidImplementationAddress();
}
