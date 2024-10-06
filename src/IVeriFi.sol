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

    /////////////////////////////////
    ////////////  ERRORS  ///////////
    /////////////////////////////////

    /// @notice Thrown when attempting to initialize with an invalid Merkle root
    error Initialization_InvalidMerkleRoot();

    /// @notice Thrown when attempting to initialize with an invalid admin address
    error Initialization_InvalidAdminAddress();

    /// @notice Thrown when attempting to update the Merkle root with an invalid value
    error UpdateMerkleRoot_InvalidMerkleRoot();

    /// @notice Thrown when attempting to add a manager with an invalid address
    error AddManager_InvalidManagerAddress();

    /// @notice Thrown when attempting to remove a manager with an invalid address
    error RemoveManager_InvalidManagerAddress();

    /// @notice Thrown when attempting to upgrade to an invalid implementation address
    error AuthorizeUpgrade_InvalidImplementationAddress();

    //////////////////////////////////
    //////////// FUNCTIONS ///////////
    //////////////////////////////////

    /// @notice Initializes the VeriFi contract
    /// @param merkleRoot Initial Merkle root value
    /// @param admin Address of the admin
    function __VeriFi_init(bytes32 merkleRoot, address admin) external;

    /// @notice Updates the Merkle root
    /// @param newRoot New Merkle root value
    function updateMerkleRoot(bytes32 newRoot) external;

    /// @notice Verifies if an account is part of the Merkle tree
    /// @param account Address of the account to verify
    /// @param proof Merkle proof for the account
    /// @return bool True if the account is verified, false otherwise
    function verify(address account, bytes32[] calldata proof) external view returns (bool);

    /// @notice Adds a new manager
    /// @param newManager Address of the new manager to add
    function addManager(address newManager) external;

    /// @notice Removes a manager
    /// @param manager Address of the manager to remove
    function removeManager(address manager) external;

    /// @notice Retrieves the current Merkle root
    /// @return bytes32 Current Merkle root value
    function getMerkleRoot() external view returns (bytes32);
}
