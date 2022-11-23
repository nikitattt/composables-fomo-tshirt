// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";

import { ISVGRenderer } from './interfaces/ISVGRenderer.sol';
import { IComposablePart } from './interfaces/IComposablePart.sol';
import { IFomoNounsTShirt } from './interfaces/IFomoNounsTShirt.sol';
import { IFomoNounsTShirtInitializer } from './interfaces/IFomoNounsTShirtInitializer.sol';
import { INounsAuctionHouse } from './interfaces/INounsAuctionHouse.sol';

contract FomoNounsTShirt is ERC1155Upgradeable, IFomoNounsTShirtInitializer, IFomoNounsTShirt, IComposablePart {
    // The owner/creator of this collection
  	address public owner;

    // An address who has permissions to mint
    address public minter;
    
    // Contract name
    string public name;

    // Contract symbol
    string public symbol;

    // Supply per token id
    mapping (uint256 => uint256) public tokenSupply;

    // The Nouns DAO Auction House
    INounsAuctionHouse public nounsAuctionHouse;

    // Part to display when Nouns DAO auction has finished
    bytes public fomoTimePart;

    // Part to display when Nouns DAO auction is active
    bytes public auctionTimePart;

    // Palette to use for parts
    bytes public palette;

    /**
     * @notice Require that the sender is the minter.
     */
    modifier onlyMinter() {
        require(_msgSender() == minter, 'Sender is not the minter');
        _;
    }
    
    /**
     * @notice Require that the sender is the minter.
     */
  	modifier onlyOwner() {
    	require(_msgSender() == owner, "Sender is not owner");
    	_;
  	}  	

    constructor(INounsAuctionHouse _nounsAuctionHouse) {
        nounsAuctionHouse = _nounsAuctionHouse;
    }
    
    function initialize(
    	string memory _name,
    	string memory _symbol,
    	address _creator,
        address _minter
    ) public override initializer {
		__ERC1155_init('');

    	name = _name;
    	symbol = _symbol;

    	owner = _creator;
        minter = _minter;    	
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        external
        onlyMinter
    {
        _mint(account, id, amount, data);

        tokenSupply[id] = tokenSupply[id] += amount;
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        external
        onlyMinter
    {
        _mintBatch(to, ids, amounts, data);
        
        uint256 len = ids.length;

        for (uint256 i = 0; i < len;) {
            tokenSupply[ids[i]] += amounts[i];

			unchecked {
            	i++;
        	}
        }
    }

    /**
     * @notice Set the Nouns DAO Auction House.
     * @dev Only callable by the owner.
     */
    function setNounsAuctionHouse(INounsAuctionHouse _nounsAuctionHouse) external override onlyOwner {
        nounsAuctionHouse = _nounsAuctionHouse;

        emit NounsAuctionHouseUpdated(_nounsAuctionHouse);
    }

    function getPart(uint256 tokenId) external override view returns (ISVGRenderer.Part memory) {
    	return _getPart();
    }

     function _getPart() internal view returns (ISVGRenderer.Part memory) {
        ISVGRenderer.Part memory part = _partByNounsAuctionState();

        return part;
    } 

    function _partByNounsAuctionState() internal view returns (ISVGRenderer.Part memory) {
        INounsAuctionHouse.Auction memory auction = nounsAuctionHouse.auction();

        bytes memory image = block.timestamp >= auction.endTime ? fomoTimePart : auctionTimePart;

        return ISVGRenderer.Part({ image: image, palette: palette });
    }

    function setPalette(bytes calldata _palette) public override onlyOwner {
        _setPalette(_palette);
    }

    function _setPalette(bytes calldata _palette) internal {
        if (_palette.length == 0) {
            revert EmptyBytes();
        }

        palette = _palette;

        emit PaletteSet(_palette);
    }

    function setFomoTimePart(bytes calldata _image) public override onlyOwner {
        _setFomoTimePart(_image);
    }

    function _setFomoTimePart(bytes calldata _image) internal {
        if (_image.length == 0) {
            revert EmptyBytes();
        }

        fomoTimePart = _image;

        emit FomoTimePartSet(_image);
    }

    function setAuctionTimePart(bytes calldata _image) public override onlyOwner {
        _setAuctionTimePart(_image);
    }

    function _setAuctionTimePart(bytes calldata _image) internal {
        if (_image.length == 0) {
            revert EmptyBytes();
        }

        auctionTimePart = _image;

        emit AuctionTimePartSet(_image);
    }
}
