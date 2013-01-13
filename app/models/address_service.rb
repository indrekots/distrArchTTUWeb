class AddressService

	attr :addressDAO, true

	def initialize
		@addressDAO = AddressDAO.new
	end

	def getAddresses(customer_id)
		@addressDAO.getAddresses(customer_id)
	end
end