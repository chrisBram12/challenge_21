pragma solidity ^0.5.5;

// Importing OpenZeppelin's ERC20, ERC20Detailed, and ERC20Mintable contracts
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

// KaseiCoin contract definition
contract KaseiCoin is ERC20, ERC20Detailed, ERC20Mintable {
    // Constructor that sets the details for the coin
    constructor(
        string memory name,
        string memory symbol,
        uint256 initial_supply
    )
        ERC20Mintable()   // Initializing the ERC20Mintable constructor
        ERC20Detailed(name, symbol, 18)  // Setting name symbol and 18 decimals
        public
    {
        // If there's an initial supply mint those tokens to the contract deployer
        if (initial_supply > 0) {
            _mint(msg.sender, initial_supply * (10 ** uint256(decimals())));
        }
    }
}
