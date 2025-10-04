//SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract TECHCRUSHNFT is ERC721 {
    // for openzeppelin installation when coding you can do- forge install openzeppelin/openzeppelin-contracts

    

    error NFTDetailsCannotBeZero();
    error NFTTotalMintCountError(uint256 _count);

    string public NFTName;

    string public NFTSymbol;

    string private baseURL;

    // tracks the total number of nft i have minted 
    uint256 private lastNFTId;

   // max NFTS of techcrush
    uint256 public constant MAX_NFTS = 100;


    constructor (string memory _NFTName, string memory _NFTSymbol, string memory _baseURL) ERC721("_NFTName", "_NFTSymbol") {
        if ((bytes(_NFTName).length ==0) || 
        (bytes(_NFTSymbol).length ==0) || 
        (bytes(_baseURL).length ==0)) {
            revert NFTDetailsCannotBeZero();

        }

        NFTName = _NFTName;
        NFTSymbol = _NFTSymbol;
        baseURL = _baseURL;

    }
// setter function - they don't have return
// getter function - they have return 

    function getBaseURL(uint256 _id) public view returns(string memory) {
        return tokenURI(_id);

    }


    function mintNFT() public {
        if (lastNFTId >= MAX_NFTS) {
            revert NFTTotalMintCountError(lastNFTId);
        }
        lastNFTId = lastNFTId + 1;
        // _safeMint(address to, uint256 tokenId)
        _safeMint(msg.sender, lastNFTId);

    }

    function setURL(string memory _baseURL) public {
        baseURL = _baseURL;
    }


    function totalSupply() public view returns (uint256) {
        return lastNFTId;

    }





}
