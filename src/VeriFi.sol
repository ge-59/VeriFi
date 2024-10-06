// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { MerkleProof } from "@oz/utils/cryptography/MerkleProof.sol";
import { AccessControlUpgradeable } from "@oz-upgradeable/access/AccessControlUpgradeable.sol";
import { UUPSUpgradeable } from "@oz-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import { Initializable } from "@oz-upgradeable/proxy/utils/Initializable.sol";

contract VeriFi is Initializable, AccessControlUpgradeable, UUPSUpgradeable {
    bytes32 public MERKLE_ROOT;
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");

    error Initialization_InvalidMerkleRoot();
    error UpdateMerkleRoot_InvalidMerkleRoot();
    error Initialization_InvalidAdminAddress();
    error AddManager_InvalidManagerAddress();

    event MerkleRootUpdated(bytes32 newRoot);
    event ManagerAdded(address newManager);

    constructor() {
        _disableInitializers();
    }

    function initialize(bytes32 merkleRoot, address admin) public initializer {
        if (merkleRoot == bytes32(0)) revert Initialization_InvalidMerkleRoot();
        if (admin == address(0)) revert Initialization_InvalidAdminAddress();
        MERKLE_ROOT = merkleRoot;
        __AccessControl_init();
        __UUPSUpgradeable_init();
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MANAGER_ROLE, admin);
    }

    function updateMerkleRoot(bytes32 newRoot) external onlyRole(MANAGER_ROLE) {
        if (newRoot == bytes32(0)) revert UpdateMerkleRoot_InvalidMerkleRoot();
        MERKLE_ROOT = newRoot;
        emit MerkleRootUpdated(newRoot);
    }

    function verify(address account, bytes32[] calldata proof) public view returns (bool) {
        bytes32 leaf = keccak256(abi.encodePacked(account));
        return MerkleProof.verify(proof, MERKLE_ROOT, leaf);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyRole(MANAGER_ROLE) {}

    function addManager(address newManager) external onlyRole(DEFAULT_ADMIN_ROLE) {
        if (newManager == address(0)) revert AddManager_InvalidManagerAddress();
        _grantRole(MANAGER_ROLE, newManager);
        emit ManagerAdded(newManager);
    }

    function removeManager(address manager) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _revokeRole(MANAGER_ROLE, manager);
    }
}
