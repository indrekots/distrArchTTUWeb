require "active_support"

class MockCustomerDAO

	def getCustomer(id)

		#work magic and get the following json
		restulJSON = '{
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
					}'
		decodedJSON =  ActiveSupport::JSON.decode(restulJSON)

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

end