// SPDX-License-Identifier: GPL-3.0

/// @title Interface for NounsToken

/*********************************
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 * ░░░░░░█████████░░█████████░░░ *
 * ░░░░░░██░░░████░░██░░░████░░░ *
 * ░░██████░░░████████░░░████░░░ *
 * ░░██░░██░░░████░░██░░░████░░░ *
 * ░░██░░██░░░████░░██░░░████░░░ *
 * ░░░░░░█████████░░█████████░░░ *
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 *********************************/

pragma solidity ^0.8.6;

import {IERC1155Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC1155/IERC1155Upgradeable.sol";
import {INounsAuctionHouse} from "./INounsAuctionHouse.sol";

interface IFomoNounsTShirt is IERC1155Upgradeable {
    event NounsAuctionHouseUpdated(INounsAuctionHouse nounsAuctionHouse);

    event FomoTimePartSet(bytes part);

    event AuctionTimePartSet(bytes part);

    event PaletteSet(bytes palette);

    error EmptyBytes();

    function setNounsAuctionHouse(INounsAuctionHouse _nounsAuctionHouse)
        external;

    function setAuctionTimePart(bytes calldata image) external;

    function setFomoTimePart(bytes calldata image) external;

    function setPalette(bytes calldata palette) external;
}
