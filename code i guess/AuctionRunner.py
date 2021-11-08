import Auction

class AuctionRunner:
	ongoingAuctions = []
	auc = Auction
	def __init__(self, ongoingAuctions):
		self.ongoingAuctions = ongoingAuctions

	def startAuction(self, auctionEnd, auctioneer, description, keywords):
		auction = self.auc.Auction(auctionEnd, auctioneer, description, keywords)
		self.ongoingAuctions.append(auction)

	def checkAuctions(self):
		for auction in self.ongoingAuctions:
			if auction.isDone():
				auction.endAuction()
				self.ongoingAuctions.remove(auction)