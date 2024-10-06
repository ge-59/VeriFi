// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;


contract VeriFi {
    bytes32 public immutable MERKLE_ROOT;

    constructor(bytes32 merkleRoot) {
        MERKLE_ROOT = merkleRoot;
    }
}
