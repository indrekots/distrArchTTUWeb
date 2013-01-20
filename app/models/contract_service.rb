class ContractService < GeneralService

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
		return isSuccess(response)
	end

	def deleteContract(id)
		response = @contractDAO.deleteContract(id)
		return isSuccess(response)
	end

end