class ContractService

	attr :contractDAO, true

	def initialize
		@contractDAO = MockContractDAO.new
	end

	def getContract(id)
		return @contractDAO.getContract(id)
	end

	def getContracts
		return @contractDAO.getContracts
	end

	def addCustomer(contract)
		@contractDAO.addContract(contract)
	end

end