//SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";
import {Strings} from "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

contract KORENNFT is ERC721 {

    error NFTDetailsCannotBeZero();
    error NFTTotalMintCountError(uint256 _count);
    string public NFTName;

    string public NFTSymbol;

    string public baseURL;

    uint256 private lastNFTId;

    uint256 public constant MAX_NFTS = 100;

    constructor (string memory _NFTName, string memory _NFTSymbol, string memory _baseURL) ERC721(_NFTName, _NFTSymbol) {
        if ((bytes(_NFTName).length == 0) || 
        (bytes(_NFTSymbol).length == 0) || 
        (bytes(_baseURL).length == 0)) {
            revert NFTDetailsCannotBeZero();
        }

        NFTName = _NFTName;
        NFTSymbol = _NFTSymbol;
        baseURL = _baseURL;

    }



    function getBaseURI(uint256 _id) public view returns (string memory) {
        return tokenURI(_id);
    } 



    function tokenURI(uint256 tokenId) public view override returns (string memory) {


        string memory json = Base64.encode(
            abi.encodePacked(
            '{"name":"KORENNFT #', 
                Strings.toString(tokenId),
                '","description":"This is a dedicated NFT for Tech Crush cohort",',
                '"image":"', baseURL, '",', 
                '"attributes":[{"trait_type":"Cohort","value":"Web3"}]',
                '}'
            )
        );

        // return tokenURI(tokenId);
        return string(abi.encodePacked("data:application/json;base64,", json));

    }


    function mintNFT() public {
        if (lastNFTId >= MAX_NFTS) {
            revert NFTTotalMintCountError(lastNFTId);
        }

        lastNFTId = lastNFTId + 1;

        _safeMint(msg.sender, lastNFTId);
    }

    function setURL(string memory _baseURL) public {
        baseURL = _baseURL;
    }


    function totalSupply() public view returns(uint256) {
        return lastNFTId; 
    }

    

    
}