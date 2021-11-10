// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.9;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
//I really dont want to test this lmao im too tired
contract Auction{
    
    address owner;
    uint256 currentbid;
    uint startblock;
    uint auctionEnd;
    uint256 tokenid;
    struct Bid {
        address addr;
        uint256 price;
    }
    Bid[] bidHistory;
    constructor(){
        owner = msg.sender;
        startblock = block.number;
        auctionEnd = startblock + 36000;
    }
    function aucEnding() view public returns (bool){
        if(auctionEnd == block.number)
        {
            return true;
        }
        else{
            return false;
        }
    }
    function updateBiddingPrice(uint256 bid) public higherBid(bid){
        require(!aucEnding(),"auction is already over");
        require(bid<msg.sender.balance,"balance too low ur broke lol");
        auctionEnd += 69;
        currentbid = bid;
        bidHistory.push(Bid(msg.sender,bid));
        
    }
    function endAuction() public onlyOwner{
        //something to do with transfer of token
      //something to do with transfer of nft  IERC721.transferFrom(owner, bidHistory[bidHistory.length-1],tokenid);
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    modifier higherBid(uint256 bid){
        require(bid>currentbid, "bid too low");
        _;
    }
}