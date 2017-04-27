from twisted.internet.protocol import Factory, Protocol
from twisted.internet import reactor

class LocationServer(Protocol):
	def connectionMade(self):
		self.factory.clients.append(self)
		print "current users are", self.factory.clients

	def connectionLost(self, reason):
		self.factory.clients.remove(self)

	def dataReceived(self, data):
		a = data.split(':')
		print a
		if len(a) >1:
			command = a[0]
			command = a[1]
		
		msg = ""
		if command == "iam" :
			self.name = content
			msg = self.name + " has joined"
		
		elif command == "loc":
			msg = self.name + ": " + content
			print msg
		
		for c in self.factory.clients:
			c.message(msg)
	
	def message(self, message):
		self.transport.write(message + '\n')

factory = Factory()
factory.protocol = LocationServer
factory.clients = []
reactor.listenTCP(21, factory)
print "Location Tracker Server Started"
reactor.run()

