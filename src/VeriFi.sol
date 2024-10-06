// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { MerkleProof } from "@oz/utils/cryptography/MerkleProof.sol";
import { AccessControlUpgradeable } from "@oz-upgradeable/access/AccessControlUpgradeable.sol";
import { UUPSUpgradeable } from "@oz-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import { Initializable } from "@oz-upgradeable/proxy/utils/Initializable.sol";
import { VeriFiStorage as Storage } from "./VeriFiStorage.sol";
import { IVeriFi } from "./IVeriFi.sol";

/// @title VeriFi
/// @notice Contract for managing a Merkle root-based verification system with role-based access control
contract VeriFi is IVeriFi, Initializable, AccessControlUpgradeable, UUPSUpgradeable {
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");

    constructor() {
        _disableInitializers();
    }

    function __VeriFi_init(bytes32 merkleRoot, address admin) external initializer {
        if (merkleRoot == bytes32(0)) revert Initialization_InvalidMerkleRoot();
        if (admin == address(0)) revert Initialization_InvalidAdminAddress();
        Storage.layout().MERKLE_ROOT = merkleRoot;
        __AccessControl_init();
        __UUPSUpgradeable_init();
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MANAGER_ROLE, admin);
    }

    function updateMerkleRoot(bytes32 newRoot) external onlyRole(MANAGER_ROLE) {
        if (newRoot == bytes32(0)) revert UpdateMerkleRoot_InvalidMerkleRoot();
        Storage.layout().MERKLE_ROOT = newRoot;
        emit MerkleRootUpdated(newRoot);
    }

    function verify(address account, bytes32[] calldata proof) external view returns (bool) {
        bytes32 leaf = keccak256(abi.encodePacked(account));
        return MerkleProof.verify(proof, Storage.layout().MERKLE_ROOT, leaf);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyRole(MANAGER_ROLE) {
        if (newImplementation == address(0)) revert AuthorizeUpgrade_InvalidImplementationAddress();
    }

    function addManager(address newManager) external onlyRole(DEFAULT_ADMIN_ROLE) {
        if (newManager == address(0)) revert AddManager_InvalidManagerAddress();
        _grantRole(MANAGER_ROLE, newManager);
        emit ManagerAdded(newManager);
    }

    function removeManager(address manager) external onlyRole(DEFAULT_ADMIN_ROLE) {
        if (manager == address(0)) revert RemoveManager_InvalidManagerAddress();
        _revokeRole(MANAGER_ROLE, manager);
        emit ManagerRemoved(manager);
    }

    function getMerkleRoot() external view returns (bytes32) {
        return Storage.layout().MERKLE_ROOT;
    }
}
