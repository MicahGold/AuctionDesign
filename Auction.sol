// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.9;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "Sender.sol";
//I really dont want to test this lmao im too tired
contract Auction{
    
    address payable owner;
    address payable holder =payable( address(0xdD870fA1b7C4700F2BD7f44238821C26f7392148));
    uint256 currentprice;
    string description;
    uint startblock;
    uint auctionEnd;
    uint256 tokenid;
    bool forced;
    IERC721 public nft;
    uint public nftId;

    Sender[] bidHistory;
    event bidUpdated(uint256 price, uint auctionEnd,Sender[] history);
    constructor(address _nftaddress, uint _nftId, uint256 startingprice, string memory _desc) descCheck(_desc) {
        nft = IERC721(_nftaddress);
        nftId = _nftId;
        description = _desc;
        owner = payable (msg.sender);
        startblock = block.number;
        auctionEnd = startblock + 36000;
        currentprice = startingprice;
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
    event latest(uint256 price);
    function updateBiddingPrice(Sender sender) public payable higherBid(sender.getAmount()) zeroBid(sender.getAmount()){
        require(!aucEnding(),"auction is already over");
        auctionEnd += 0;
        currentprice = sender.getAmount();
        bidHistory.push(sender);
        emit bidUpdated(currentprice, currentprice, bidHistory);
    }
    function endAuction() payable public onlyHolder(){ 
        require(aucEnding(),"auction hasn't ended");
        if(!forced){
            nft.safeTransferFrom(owner, bidHistory[bidHistory.length-1].getAddress(),tokenid);
            owner.transfer(currentprice); 
        }
        else{
            for(uint256 a=0;a<bidHistory.length;a++){
                bidHistory[a].getAddress().transfer((bidHistory[a].getAmount()));
            }
            //what do i even do here lol
        }
    }
    function latestB() public view returns (uint256 price)
    {
        return currentprice;
    }
    function latestBid() public returns(string memory){
        emit latest(currentprice);
        return "";
    }
    modifier onlyHolder() {
        require(msg.sender == holder, "Not holder");
        _;
    }
    modifier zeroBid(uint256 bid)
    {
        require(bid!=0);
        _;
    }
    modifier higherBid(uint256 bid){
        require(bid>currentprice, "bid too low");
        _;
    }
}