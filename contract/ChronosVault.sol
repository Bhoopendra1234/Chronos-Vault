// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ChronosVault {
    struct Vault {
        uint256 lockedAmount;    // Amount of ETH locked
        uint256 unlockTime;      // Timestamp when funds can be withdrawn
        address owner;           // Owner of this vault
        bool withdrawn;          // Prevents double withdrawal
    }

    // Mapping: vaultId => Vault details
    mapping(uint256 => Vault) public vaults;
    
    // Auto-incrementing vault ID
    uint256 public nextVaultId;

    // Events
    event VaultCreated(
        uint256 indexed vaultId,
        address indexed owner,
        uint256 amount,
        uint256 unlockTime
    );

    event FundsWithdrawn(
        uint256 indexed vaultId,
        address indexed owner,
        uint256 amount
    );

    event VaultExtended(
        uint256 indexed vaultId,
        uint256 newUnlockTime
    );

    /// @notice Create a new time-locked vault
    /// @param _unlockTime Future timestamp when funds become withdrawable
    function createVault(uint256 _unlockTime) external payable returns (uint256 vaultId) {
        require(msg.value > 0, "Must deposit ETH");
        require(_unlockTime > block.timestamp, "Unlock time must be in the future");

        vaultId = nextVaultId++;
        vaults[vaultId] = Vault({
            lockedAmount: msg.value,
            unlockTime: _unlockTime,
            owner: msg.sender,
            withdrawn: false
        });

        emit VaultCreated(vaultId, msg.sender, msg.value, _unlockTime);
    }

    /// @notice Withdraw funds from a matured vault
    /// @param _vaultId The ID of the vault to withdraw from
    function withdraw(uint256 _vaultId) external {
        Vault storage vault = vaults[_vaultId];
        
        require(vault.owner == msg.sender, "Not vault owner");
        require(!vault.withdrawn, "Already withdrawn");
        require(block.timestamp >= vault.unlockTime, "Vault still locked");

        vault.withdrawn = true;
        uint256 amount = vault.lockedAmount;

        emit FundsWithdrawn(_vaultId, msg.sender, amount);

        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent, "Failed to send ETH");
    }

    /// @notice Extend the lock period of your own vault (optional self-discipline feature)
    /// @param _vaultId The vault ID
    /// @param _newUnlockTime New unlock timestamp (must be later than current)
    function extendLock(uint256 _vaultId, uint256 _newUnlockTime) external {
        Vault storage vault = vaults[_vaultId];
        
        require(vault.owner == msg.sender, "Not vault owner");
        require(_newUnlockTime > vault.unlockTime, "New time must be later");

        vault.unlockTime = _newUnlockTime;

        emit VaultExtended(_vaultId, _newUnlockTime);
    }

    /// @notice View function to check vault details
    function getVault(uint256 _vaultId) external view returns (Vault memory) {
        return vaults[_vaultId];
    }
}
