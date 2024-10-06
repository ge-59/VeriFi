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
}