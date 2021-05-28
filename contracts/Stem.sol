pragma solidity ^0.7.3;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Stem is ERC721, Ownable {

  uint constant common = 5;
  uint constant rare = 4;
  uint constant legendary = 3;
  uint constant exotic = 2;
  uint constant one = 1;

  struct Collection {
    uint id;
    string name;
    uint common;
    uint rare;
    uint legendary;
    uint exotic;
    uint one;
  }

  uint256 public tokenCounter;
  uint256 public collectionsCount;
  mapping (string => Collection) collections;

  uint256 constant MIN_STAKE = 1 ether;
  uint256 constant MAX_STAKE = 2000 ether;

  event NftBurned(address indexed beneficiary, uint256 tokenId);

  constructor () ERC721 ("StemCards", "STEM"){
    tokenCounter = 0;
    collectionsCount = 0;
  }

  function buy(string memory collectionName) public payable returns (uint256) {
    require(validPurchase(), "Invalid purchase!");
    uint256 newItemId = generateId(collectionName, common);
    _safeMint(msg.sender, newItemId);
    _setTokenURI(newItemId, string(abi.encodePacked("https://stem.cards/", collectionName, "/", newItemId, ".json")));
    collections[collectionName].common--;
    tokenCounter = tokenCounter + 1;
    return newItemId;
  }

  function validPurchase() internal returns (bool) {
    bool withinRangePurchase = (msg.value >= MIN_STAKE && msg.value <= MAX_STAKE);
    return withinRangePurchase;
  }

  function burnToken(uint256 tokenId) public {
    _burn(tokenId);
    NftBurned(msg.sender, tokenId);
  }

  function createCollection(string memory name) onlyOwner public {
    collections[name].id = collectionsCount;
    collections[name].name = name;
    collections[name].common = 1000;
    collections[name].rare = 200;
    collections[name].legendary = 100;
    collections[name].exotic = 10;
    collections[name].one = 1;
    collectionsCount++;
  }

  function getCollection(string memory name) public view returns (Collection memory) {
    return collections[name];
  }

  function generateId(string memory name, uint rarity) internal returns (uint256) {
    uint256 collectionMultiplyer = 100000;
    uint256 typeMultiplyer = 10000;
    uint256 collectionStart = 100;

    uint256 id = (collectionStart + collectionsCount) * collectionMultiplyer;

    id = id + (rarity * typeMultiplyer);
    if (rarity == one) {
      id = id + collections[name].one;
    } else if (rarity == exotic) {
      id = id + collections[name].exotic;
    } else if (rarity == legendary) {
      id = id + collections[name].legendary;
    } else if (rarity == rare) {
      id = id + collections[name].rare;
    } else {
      id = id + collections[name].common;
    }

    return id;
  }
}