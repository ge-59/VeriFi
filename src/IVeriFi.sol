// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

/// @title IVeriFi
/// @dev Interface for VeriFi contract containing all events, errors and external functions
interface IVeriFi {
    /////////////////////////////////
    ////////////  EVENTS  ///////////
    /////////////////////////////////

    /// @notice Emitted when the Merkle root is updated
    /// @param newRoot The new Merkle root value
    event MerkleRootUpdated(bytes32 newRoot);

    /// @notice Emitted when a new manager is added
    /// @param newManager Address of the newly added manager
    event ManagerAdded(address newManager);

    /// @notice Emitted when a manager is removed
    /// @param manager Address of the removed manager
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
