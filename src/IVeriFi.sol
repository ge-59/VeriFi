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

    function __VeriFi_init(bytes32 merkleRoot, address admin) external;
    function updateMerkleRoot(bytes32 newRoot) external;
    function verify(address account, bytes32[] calldata proof) external view returns (bool);
    function addManager(address newManager) external;
    function removeManager(address manager) external;
    function getMerkleRoot() external view returns (bytes32);
}
