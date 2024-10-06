// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { MerkleProof } from "@oz/utils/cryptography/MerkleProof.sol";

contract VeriFi {
    bytes32 public immutable MERKLE_ROOT;

    constructor(bytes32 merkleRoot) {
        MERKLE_ROOT = merkleRoot;
    }

    function verifyAddress(address account, bytes32[] calldata proof) public view returns (bool) {
        
    }
}
