// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { MerkleProof } from "@oz/utils/cryptography/MerkleProof.sol";
import { AccessControl } from "@oz/access/AccessControl.sol";

contract VeriFi is AccessControl {
    bytes32 public MERKLE_ROOT;
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");

    error Constructor_InvalidMerkleRoot();
    error UpdateMerkleRoot_InvalidMerkleRoot();

    event MerkleRootUpdated(bytes32 newRoot);

    constructor(bytes32 merkleRoot, address admin) {
        if (merkleRoot == bytes32(0)) revert Constructor_InvalidMerkleRoot();
        MERKLE_ROOT = merkleRoot;
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
}
