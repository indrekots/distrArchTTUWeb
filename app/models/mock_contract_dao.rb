require 'rubygems'
require 'httparty'
require "active_support"

class MockContractDAO

	def getContract(id)
		#work magic and get the following json
		#currently gets all mocked customers and returns the one with the given id
		contracts = getContracts
		contracts.each do |contract|
			if contract.id.to_s == id
				return contract
			end
		end

		return nil
	end

	def getContracts
		resultJSON = HTTParty.get('http://hajusssteem.apiary.io/contract/list')
		decodedJSON =  ActiveSupport::JSON.decode(resultJSON)
		resultArray = Array.new

		decodedJSON.each do |c|
			resultArray.push(createContractFromDecodedJSON(c))
		end

		return resultArray
	end

	def getContractsmock
		##TODO: use real resource
		resultJSON = '[
						{
							"name":"Name",
							"id":1,
							"description":"desc",
							"note":"",
							"contractNumber":123,
							"validFrom":"2012-11-07T10:23:22.331+0000",
							"validTo":"2012-11-07T10:23:22.331+0000",
							"parentContract":null,
							"parentConractId":null,
							"conditions":"asasasa"
						},
						{
							"name":"Name ww",
							"id":2,
							"description":"desc",
							"note":"",
							"contractNumber":123,
							"validFrom":"2012-11-07T10:42:54.797+0000",
							"validTo":"2012-11-07T10:42:54.797+0000",
							"parentContract":null,
							"parentConractId":null,
							"conditions":"asasasa"
						},
						{
							"name":null,
							"id":3,
							"description":null,
							"note":null,
							"contractNumber":null,
							"validFrom":null,
							"validTo":null,
							"parentContract":null,
							"parentConractId":null,
							"conditions":null
						},
						{
							"name":null,
							"id":4,
							"description":null,
							"note":null,
							"contractNumber":null,
							"validFrom":null,
							"validTo":null,
							"parentContract":null,
							"parentConractId":null,
							"conditions":null
						},
						{
							"name":"blabl",
							"id":5,
							"description":null,
							"note":null,
							"contractNumber":null,
							"validFrom":null,
							"validTo":null,
							"parentContract":{
												"name":"Name",
												"id":1,
												"description":"desc",
												"note":"",
												"contractNumber":123,
												"validFrom":"2012-11-07T10:23:22.331+0000",
												"validTo":"2012-11-07T10:23:22.331+0000",
												"parentContract":null,
												"parentConractId":null,
												"conditions":"asasasa"
											},
							"parentConractId":1,
							"conditions":null
						}
					  ]'

		decodedJSON =  ActiveSupport::JSON.decode(resultJSON)
		resultArray = Array.new

		decodedJSON.each do |c|
			resultArray.push(createContractFromDecodedJSON(c))
		end

		return resultArray
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
		contract.parentConractId = decodedJSON["parentConractId"]
		contract.conditions = decodedJSON["conditions"]
		return contract
	end

	def addContract(contract)

	end

end


