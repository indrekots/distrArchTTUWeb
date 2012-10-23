#require './mock_customer_dao'

class CustomerService

	attr :customerDAO, true

	def initialize
		@customerDAO = MockCustomerDAO.new
	end

	def getCustomer(id)
		@customerDAO.getCustomer(id)
	end


end