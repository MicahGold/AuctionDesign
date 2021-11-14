// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.9;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "Sender.sol";
//I really dont want to test this lmao im too tired
contract Auction{
    
    address payable owner;
 
    uint256 currentprice;
    string description;
    uint startblock;
    uint auctionEnd;
    bool forced;
    IERC721 public nft;
    uint public nftId;
    struct Bid {
        address payable addr;
        uint256 price;
    }
    Bid[] bidHistory;
    event bidUpdated(uint256 price, uint auctionEnd,Sender[] history);
    constructor(uint256 startingprice, string memory _desc) descCheck(_desc) {

        description = _desc;
        owner = payable (msg.sender);
        startblock = block.number;
        auctionEnd = startblock + 36000;
        currentprice = startingprice;
        forced = false;
    }
    function setNft(address _nftaddress, uint _nftId) public{
        nft = IERC721(_nftaddress);
        nftId = _nftId;
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
    event latest(uint256 price);
    function updateBiddingPrice(uint256 bid) public higherBid(bid) {
        require(!aucEnding(),"auction is already over");
        require(msg.sender.balance > bid,"u broke");
        auctionEnd += 0;
        currentprice = bid;
        bidHistory.push(Bid(payable(msg.sender),bid));
    }
    //prompt highest bidder to send money to the person if it wasnt force ended
    //if transaction isn't required then it cancels transfer
    function endAuction(Sender sendy) payable public toOwner(sendy){ 
        require(aucEnding(),"auction hasn't ended");
        if(!forced && msg.sender==bidHistory[bidHistory.length-1].addr){
            nft.safeTransferFrom(address(this), msg.sender, nftId);
            sendy.execute();
        }
        else{
            sendy.cancel;
        }
    }
    modifier sameasHighest(uint256 bid){
        require(bid ==  bidHistory[bidHistory.length-1].price);
        _;
    }
    function latestB() public view returns (uint256 price)
    {
        return currentprice;
    }
    function ownerBoi() public view returns(address){
        return owner;
    }
    modifier toOwner(Sender s)
    {
        require(s.receiver() == owner);
        _;
    }
    function latestBid() public returns(string memory){
        emit latest(currentprice);
        return "";
    }
 
    modifier zeroBid(uint256 bid)
    {
        require(bid!=0);
        _;
    }
    modifier higherBid(uint256 bid){
        require(bid>=currentprice, "bid too low");
        _;
    }
}