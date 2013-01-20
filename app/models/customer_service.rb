#require './mock_customer_dao'

class CustomerService

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
	end

	private
	def checkResponseForErrors(response)
		if response.code != 200
			return true
		else
			return false
		end
	end

	private
	def isSuccess(response)
		return !checkResponseForErrors(response)
	end
end