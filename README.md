# Chronos Vault ⏳

**Lock your ETH today. Free it tomorrow.**

Chronos Vault is a fully decentralized, non-custodial time-lock smart contract that allows anyone to deposit ETH and set a future unlock date. Once locked, funds are immutable until the chosen time arrives — perfect for commitment devices, inheritance planning, long-term savings, or forcing yourself to HODL.

## Project Vision

To give individuals true sovereignty over their wealth by combining the irreversibility of blockchain with the discipline of time. In a world of instant gratification, Chronos Vault is the unbreakable piggy bank for the future you want to build.

## Key Features

- **One-click time locking** – Deposit ETH and choose any future unlock timestamp.
- **No custodians, no backdoors** – Only the owner can withdraw, and only after the lock expires.
- **Extendable lock** – You can always push the unlock date further (but never earlier).
- **Transparent & auditable** – Simple, minimal code with clear events.
- **ETH-native** – No tokens, no middlemen — just pure Ethereum.

## How It Works

1. Call `createVault(unlockTime)` with ETH and a future timestamp.
2. Your funds are locked in the contract under a unique vault ID.
3. When `block.timestamp >= unlockTime`, call `withdraw(vaultId)` to reclaim your ETH.
4. Optionally call `extendLock()` to increase commitment.

## Future Scope

- Support for ERC20 token vaults (USDC, WBTC, etc.)
- Multiple beneficiaries with percentage splits (digital will)
- Recurring lock schedules
- Integration with prediction markets ("I'll lock 10 ETH until [event]")
- NFT representation of locked vaults
- Frontend dApp with beautiful calendar UI

## Security

- Reentrancy protected
- Uses `call` with checks-effects-interactions pattern
- No upgradeability = no admin keys

Audited logic, minimal attack surface. Ready for mainnet deployment.

**"Time is the ultimate commitment device. Chronos Vault makes it unbreakable."**

Deploy. Lock. Thrive.
contract address:0xB03D31D960c97b71c21300226a8c3C4A321758aB
<img width="1332" height="167" alt="image" src="https://github.com/user-attachments/assets/5b5bbdbe-d045-4ccb-9c36-702050a7ac07" />
