pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

// KaseiCoinCrowdsale contract that inherits from OpenZeppelin's Crowdsale and MintedCrowdsale
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {
    
    // Constructor to initialize Crowdsale parameters
    constructor(
        uint256 rate,               // Rate of token per Ether
        address payable wallet,    // Address where collected funds will be forwarded
        IERC20 token               // The token to be sold
    ) 
    public 
    Crowdsale(rate, wallet, token) {
        // constructor can stay empty since we have initialized parameters above
    }
}

// KaseiCoinCrowdsaleDeployer to deploy and manage the KaseiCoin and its Crowdsale
contract KaseiCoinCrowdsaleDeployer {

    address public kasei_token_address;
    address public kasei_crowdsale_address;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet
    ) 
    public {
        // Ensure there's a minimum gas provided for this function
        require(gasleft() >= 5000000, "Minimum gas requirement not met");

        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        kasei_token_address = address(token);

        KaseiCoinCrowdsale kaseiCrowdsale = new KaseiCoinCrowdsale(1, wallet, token);
        kasei_crowdsale_address = address(kaseiCrowdsale);

        token.addMinter(kasei_crowdsale_address);
        token.renounceMinter();
    }
}
