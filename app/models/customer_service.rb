#require './mock_customer_dao'

class CustomerService < GeneralService

	attr :customerDAO, true

	def initialize
		@customerDAO = CustomerDAO.new
	end

	def getCustomer(id)
		return @customerDAO.getCustomer(id)
	end

	def getCustomers
		return @customerDAO.getCustomers
	end

	def addCustomer(customer)
		response = @customerDAO.addCustomer(customer)

		return isSuccess(response)
	end

	def deleteCustomer(id)
		@customerDAO.deleteCustomer(id)

		return isSuccess(response)
	end

end