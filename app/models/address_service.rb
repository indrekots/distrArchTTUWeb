class AddressService < GeneralService

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
		response = @addressDAO.addAddress(address)
		return isSuccess(response)
	end

	def deleteAddress(id, customer_id)
		response = @addressDAO.deleteAddress(id, customer_id)
		return isSuccess(response)
	end
end