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
		response = @customerDAO.deleteCustomer(id)
		return isSuccess(response)
	end

	def search(firstName)
		return @customerDAO.search(firstName)
	end

end