# Initial Plan

## Hypotheses

These hypotheses are derived from the project description given in `contracts/README.md`.

> A smart contract applicatoin for storing a password. Users should be able to store a password and then retrieve it later. Others should not be able to access the password. 

The contract can be broken so that:

1. users cannot retrieve a password.
2. users cannot store a password.
3. a user can retrieve another user's password.
4. [H-01] a user can store a password for a contract they do not own.
