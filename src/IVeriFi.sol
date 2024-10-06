// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface IVeriFi {
    event MerkleRootUpdated(bytes32 newRoot);
    event ManagerAdded(address newManager);
    event ManagerRemoved(address manager);
}
