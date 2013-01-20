require 'rubygems'
require 'httparty'
require 'active_support'
require 'json'

class ContractDAO
	BASE_SERVICE_URL = ServiceHelper.new.getServiceURL

	def getContract(id)
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/contract/' + id.to_s)
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		return createContractFromDecodedJSON(resultJSON)
	end

	def getContracts()
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/contract/list')
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		resultArray = Array.new

		decodedJSON.each do |c|
			resultArray.push(createContractFromDecodedJSON(c))
		end

		return resultArray
	end

	def addContract(contract)
		if contract.id.nil?
			return addNewContract(contract)
		else
			return addExistingContract(contract)
		end
	end

	def deleteContract(id)
		response = HTTParty.delete(BASE_SERVICE_URL + '/contract/' + id.to_s,
			:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
		return response
	end

	private 
	def addNewContract(contract)
		response = HTTParty.post(BASE_SERVICE_URL + '/contract', :query => {
				:id => contract.id,
				:name => contract.name,
				:description => contract.note,
				:contractNumber => contract.contractNumber,
				:validFrom => contract.validFrom,
				:validTo => contract.validTo,
				:parentConract => contract.parentContract,
				:parentConractId => contract.parentContractId,
				:conditions => contract.conditions
				},
				:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
		return response
	end

	private
	def addExistingContract(contract)
		response = HTTParty.put(BASE_SERVICE_URL + '/contract/' + contract.id.to_s, :query => {
				:id => contract.id,
				:name => contract.name,
				:description => contract.note,
				:contractNumber => contract.contractNumber,
				:validFrom => nil,
				:validTo => nil,
				:parentConract => contract.parentContract,
				:parentConractId => contract.parentContractId,
				:conditions => contract.conditions
				},
				:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
		return response
	end

	def createContractFromDecodedJSON(decodedJSON)
		contract = Contract.new
		contract.id = decodedJSON["id"]
		contract.name = decodedJSON["name"]
		contract.description = decodedJSON["description"]
		contract.note = decodedJSON["note"]
		contract.contractNumber = decodedJSON["contractNumber"]
		contract.validFrom = decodedJSON["validFrom"]
		contract.validTo = decodedJSON["validTo"]
		contract.parentContract = decodedJSON["parentContract"]
		contract.parentContractId = decodedJSON["parentConractId"]
		contract.conditions = decodedJSON["conditions"]
		return contract
	end

end