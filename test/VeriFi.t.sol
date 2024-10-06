// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test, console2} from "forge-std/Test.sol";
import {VeriFi} from "../src/VeriFi.sol";

contract VeriFiTest is Test {
    VeriFi public veriFi;
    address public admin;
    address public manager;

    function setUp() public {
        admin = makeAddr("admin");
        manager = makeAddr("manager");
    }
}