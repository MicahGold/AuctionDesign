import Auction
import AuctionRunner
runner = AuctionRunner
auction = Auction
runnerboi = runner.AuctionRunner([])
runnerboi.startAuction(10,"0xF5A0C4d7259005612bE593f163f7f1a475FD5E51","description", ["yes","other keyword"])
runnerboi.ongoingAuctions[0].addTime(800)
runnerboi.ongoingAuctions[0].updateBiddingPrice(40,"user1's wallet",40)
print(runnerboi.ongoingAuctions[0].getCurrentBiddingPrice())
runnerboi.ongoingAuctions[0].updateBiddingPrice(90,"user2's wallet",100)
print("endauction does the transferring within it by the way")
runnerboi.ongoingAuctions[0].setAuctionEnd(0)
runnerboi.checkAuctions()