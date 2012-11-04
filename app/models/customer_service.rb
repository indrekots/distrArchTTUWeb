#require './mock_customer_dao'

class CustomerService

	attr :customerDAO, true

	def initialize
		@customerDAO = MockCustomerDAO.new
	end

	def getCustomer(id)
		return @customerDAO.getCustomer(id)
	end

	def getCustomers
		return @customerDAO.getCustomers
	end

	def addCustomer(customer)
		@customerDAO.addCustomer(customer)
	end


end