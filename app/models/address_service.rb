class AddressService

	attr :addressDAO, true

	def initialize
		@addressDAO = AddressDAO.new
	end

	def getAddresses(customer_id)
		@addressDAO.getAddresses(customer_id)
	end

	def getAddress(id, customer_id)
		@addressDAO.getAddress(id, customer_id)
	end

	def addAddress(address)
		@addressDAO.addAddress(address)
	end

	def deleteAddress(id, customer_id)
		@addressDAO.deleteAddress(id, customer_id)
	end
end