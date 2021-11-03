class Auction:
	auctionEnd = None
	auctioneer = None
	bidHistory = None
	description = ""
	keywords = None
	currentBiddingPrice = None
	hot = False
	def __init__(self, auctionEnd, auctioneer, description, keywords):
		if not description.count(" ") > 100:
			self.auctionEnd = auctionEnd
			self.auctioneer = auctioneer
			self.bidHistory = []
			self.description = description
			self.keywords = keywords
			self.currentBiddingPrice = 0
			self.hot = False
		else:
			raise Exception("description too long")            

	def updateBiddingPrice(self, price, user, userbal):
		if price > self.currentBiddingPrice and userbal>price:
			self.currentBiddingPrice = price
			self.auctionEnd = self.auctionEnd + 69
			self.bidHistory.append([user,price])
		else:
			if price <= self.currentBiddingPrice:
				raise Exception("are youa ctually gonna bid lol")                
			if userbal<price:
				raise Exception("bruh u broke lmao")            

	def addTime(self, time):
		self.auctionEnd = self.auctionEnd + time

	def endAuction(self):
		#transfer coin from customer's wallet to auctioneer's wallet (92% of coin)
		#add item to auctioneer's inventory
		self.aucTransfer()

	def aucTransfer(self):
		print("transfer "+str(self.currentBiddingPrice*0.92)+" from "+self.bidHistory[len(self.bidHistory)-1][0]+" to "+self.auctioneer+" and transfer nft the other way around")
		print("the last 8% ("+str(self.currentBiddingPrice*0.08)+") goes to a wallet for use on computing costs")
	def isHot(self):
		return True

	def isDone(self):
		return self.auctionEnd == 0
	def getAuctionEnd(self):
		return self.auctionEnd

	def setAuctionEnd(self, time):
		self.auctionEnd = time
	def getAuctioneer(self):
		return self.auctioneer

	def getBidHistory(self):
		return self.bidHistory

	def getDescription(self):
		return self.description

	def getKeywords(self):
		return self.keywords

	def getCurrentBiddingPrice(self):
		return self.currentBiddingPrice

	def getHot(self):
		return self.hot