// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test, console2} from "forge-std/Test.sol";
import {VeriFi} from "../src/VeriFi.sol";
import {ERC1967Proxy} from "@oz/proxy/ERC1967/ERC1967Proxy.sol";

contract VeriFiTest is Test {
    VeriFi public veriFiImplementation;
    VeriFi public veriFi;
    address public admin;
    address public manager;
    address public user;
    bytes32 public initialRoot;

    function setUp() public {
        admin = makeAddr("admin");
        manager = makeAddr("manager");
        user = makeAddr("user");
        initialRoot = keccak256("initialRoot");

        veriFiImplementation = new VeriFi();
        bytes memory initData = abi.encodeWithSelector(
            VeriFi.__VeriFi_init.selector,
            initialRoot,
            admin
        );
        ERC1967Proxy proxy = new ERC1967Proxy(address(veriFiImplementation), initData);
        veriFi = VeriFi(address(proxy));
    }

    function test_InitialState() public {
        assertEq(veriFi.getMerkleRoot(), initialRoot, "Initial Merkle root should be set correctly");
        assertTrue(veriFi.hasRole(veriFi.DEFAULT_ADMIN_ROLE(), admin), "Admin should have DEFAULT_ADMIN_ROLE");
        assertTrue(veriFi.hasRole(veriFi.MANAGER_ROLE(), admin), "Admin should have MANAGER_ROLE");
        assertFalse(veriFi.hasRole(veriFi.MANAGER_ROLE(), manager), "Manager should not have MANAGER_ROLE initially");
    }

    function test_UpdateMerkleRoot() public {
        bytes32 newRoot = keccak256("newRoot");
        
        vm.prank(admin);
        veriFi.updateMerkleRoot(newRoot);
        
        assertEq(veriFi.getMerkleRoot(), newRoot, "Merkle root should be updated");
    }

    function test_AddManager() public {
        vm.prank(admin);
        veriFi.addManager(manager);
        
        assertTrue(veriFi.hasRole(veriFi.MANAGER_ROLE(), manager), "Manager should have MANAGER_ROLE after being added");
    }

    function test_RemoveManager() public {
        vm.startPrank(admin);
        veriFi.addManager(manager);
        veriFi.removeManager(manager);
        
        assertFalse(veriFi.hasRole(veriFi.MANAGER_ROLE(), manager), "Manager should not have MANAGER_ROLE after being removed");
    }

    function testFail_UpdateMerkleRoot_NonManager() public {
        bytes32 newRoot = keccak256("newRoot");
        
        vm.prank(user);
        veriFi.updateMerkleRoot(newRoot);
    }

    function testCheck() public {}
}