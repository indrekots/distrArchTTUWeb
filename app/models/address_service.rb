class AddressService < GeneralService

	attr :addressDAO, true

	def initialize
		@addressDAO = AddressDAO.new
	end

	def getAddresses(customerId)
		@addressDAO.getAddresses(customerId)
	end

	def getAddress(id, customerId)
		@addressDAO.getAddress(id, customerId)
	end

	def addAddress(address, customerId)
		response = @addressDAO.addAddress(address, customerId)
		return isSuccess(response)
	end

	def deleteAddress(id, customerId)
		response = @addressDAO.deleteAddress(id, customerId)
		return isSuccess(response)
	end
end