// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from "../lib/forge-std/src/Script.sol";
import {KorenNFT} from "../src/KorenNFT.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract KorenNFTScript is Script {
    string public name = "Koren NFT";
    string public symbol = "KRN";
    KorenNFT public korennft;

    // Inline SVG image (encoded)
    string public svgBase64 = string(
        abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(
                abi.encodePacked(
                    "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"400\" height=\"400\">",
                    "<rect width=\"100%\" height=\"100%\" fill=\"black\"/>",
                    "<text x=\"50%\" y=\"50%\" fill=\"white\" font-size=\"24\" text-anchor=\"middle\" dominant-baseline=\"middle\">Koren NFT</text>",
                    "</svg>"
                )
            )
        )
    );

    function run() external {
        vm.startBroadcast();

        // Deploy the NFT contract
        korennft = new KorenNFT(name, symbol, svgBase64);

        // Mint an NFT to msg.sender
        korennft.mintNFT();

        vm.stopBroadcast();

        console.log("NFT Contract Deployed Successfully!");
        console.log("NFT Address:", address(korennft));


        string memory nftMetadata = korennft.tokenURI(1);
        console.log("NFT Token URI:", nftMetadata);
    }
}
