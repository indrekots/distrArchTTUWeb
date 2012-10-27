require "active_support"

class MockCustomerDAO

	def getCustomer(id)

		#work magic and get the following json
		#currently gets all mocked customers and returns the one with the given id
		customers = getCustomers
		customers.each do |customer|
			if customer.id.to_s == id
				return customer
			end
		end

		return nil
	end

	def getCustomers
		#work magic and get all customers from web service
		restulJSON = '[
						{
						  "id": 1,
						  "cstType": 1,
						  "cstStateType": 1,
						  "firstName": "Indrek",
						  "lastName": "Ots",
						  "identityCode": 38811210016,
						  "note": "awesome",
						  "birthDate": "21.11.1988",
						  "created": "2012-10-23 22:00:00",
						  "updated": "2012-10-23 22:00:00",
						  "createdBy": 1,
						  "updatedBy": 1
						},
						{
						  "id": 2,
						  "cstType": 1,
						  "cstStateType": 1,
						  "firstName": "Aivar",
						  "lastName": "Kaalep",
						  "identityCode": 39010010021,
						  "note": "awesome ei ole",
						  "birthDate": "01.10.1990",
						  "created": "2012-10-23 22:00:00",
						  "updated": "2012-10-23 22:00:00",
						  "createdBy": 1,
						  "updatedBy": 1
						},
						{
						  "id": 3,
						  "cstType": 2,
						  "cstStateType": 3,
						  "firstName": "Anu",
						  "lastName": "Saagim",
						  "identityCode": 46010010021,
						  "note": "bravuuritar",
						  "birthDate": "01.10.1960",
						  "created": "2012-10-25 14:00:00",
						  "updated": "2012-10-25 14:00:00",
						  "createdBy": 1,
						  "updatedBy": 1
						}
					]'

		decodedJSON =  ActiveSupport::JSON.decode(restulJSON)
		resultArray = Array.new

		decodedJSON.each do |c|
			resultArray.push(createCustomerFromDecodedJSON(c))
		end

		return resultArray

	end

	def createCustomerFromDecodedJSON(decodedJSON)
		customer = Customer.new
		customer.id = decodedJSON["id"]
		customer.cstType = decodedJSON["cstType"]
		customer.cstStateType = decodedJSON["cstStateType"]
		customer.firstName = decodedJSON["firstName"]
		customer.lastName = decodedJSON["lastName"]
		customer.identityCode = decodedJSON["identityCode"]
		customer.note = decodedJSON["note"]
		customer.birthDate = decodedJSON["birthDate"]
		customer.created = decodedJSON["updated"]
		customer.createdBy = decodedJSON["createdBy"]
		customer.updatedBy = decodedJSON["updatedBy"]
		return customer
	end

	##TODO: add rest calls for adding a new customer

end