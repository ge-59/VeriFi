// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { MerkleProof } from "@oz/utils/cryptography/MerkleProof.sol";

contract VeriFi {
    bytes32 public immutable MERKLE_ROOT;

    error Constructor_InvalidMerkleRoot();

    constructor(bytes32 merkleRoot) {
        if (merkleRoot == bytes32(0)) revert Constructor_InvalidMerkleRoot();
        MERKLE_ROOT = merkleRoot;
    }

    function verify(address account, bytes32[] calldata proof) public view returns (bool) {
        bytes32 leaf = keccak256(abi.encodePacked(account));
        return MerkleProof.verify(proof, MERKLE_ROOT, leaf);
    }
}
