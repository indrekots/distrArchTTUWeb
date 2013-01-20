class ContractService

	attr :contractDAO, true

	def initialize
		@contractDAO = ContractDAO.new
	end

	def getContract(id)
		return @contractDAO.getContract(id)
	end

	def getContracts
		return @contractDAO.getContracts
	end

	def addContract(contract)
		response = @contractDAO.addContract(contract)
	end

	def deleteContract(id)
		@contractDAO.deleteContract(id)
	end

end