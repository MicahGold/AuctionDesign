// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.9;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
contract NFTCHecker{
    IERC721 nft;
    uint nftId;
    constructor(address _nftaddress, uint _nftId) public{
        nft = IERC721(_nftaddress);
        nftId = _nftId;
    }
    function checkOwner() view public returns(address){
        return nft.ownerOf(nftId);
    }
}