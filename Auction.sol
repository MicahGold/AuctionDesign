// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.9;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

//I really dont want to test this lmao im too tired
contract Auction{
    
    address payable owner;
    uint256 currentprice;
    string description;
    uint startblock;
    uint auctionEnd;
    uint256 tokenid;
    bool forced;
    IERC721 public nft;
    uint public nftId;
    struct Bid {
        address addr;
        uint256 price;
    }
    Bid[] bidHistory;
    event bidUpdated(uint256 price, uint auctionEnd,Bid[] history);
    constructor(address _nftaddress, uint _nftId, string memory _desc) descCheck(_desc){
        nft = IERC721(_nftaddress);
        nftId = _nftId;
        description = _desc;
        owner = payable (msg.sender);
        startblock = block.number;
        auctionEnd = startblock + 36000;
        currentprice = 0;
        forced = false;
    }
    modifier descCheck(string memory desc)
    {
        require(100>countWords(),"words too high");
        _;
    }
    function countWords() public pure returns(uint256){
        uint256 count = 0;
       // for(uint256 a=0;a<bytes(words).length;a++){
      //    if ( words[0] == " "){
   //           count +=1;
      //    }
      //  }
      return count;
    }
    function aucEnding() view public returns (bool){
        return (auctionEnd <= block.number);

    }
    function timeLeft() view public returns(uint256){
       return(auctionEnd- block.number);
    }
    function forceEndAuction() public{
        auctionEnd = block.number;
        forced= true;
    }
    event latest(address _address,uint256 price);
    function updateBiddingPrice() public payable higherBid(msg.value){
        require(!aucEnding(),"auction is already over");
        require(msg.value<msg.sender.balance,"balance too low ur broke lol");
        auctionEnd += 0;
        currentprice = msg.value;
        bidHistory.push(Bid(msg.sender,msg.value));
        emit bidUpdated(currentprice, currentprice, bidHistory);
    }
    function endAuction() payable public{
        require(aucEnding(),"auction hasn't ended");
        if(!forced){
            nft.safeTransferFrom(owner, bidHistory[bidHistory.length-1].addr,tokenid);
            owner.transfer(bidHistory[bidHistory.length-1].price); 
        }
        else{
            //what do i even do here lol
        }
    }
    function latestBid() public returns(string memory){
        emit latest(bidHistory[bidHistory.length-1].addr,bidHistory[bidHistory.length-1].price);
        return "";
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    modifier higherBid(uint256 bid){
        require(bid>currentprice, "bid too low");
        _;
    }
}