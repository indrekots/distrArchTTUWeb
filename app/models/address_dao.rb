require 'rubygems'
require 'httparty'
require "active_support"

class AddressDAO

	BASE_SERVICE_URL = ServiceHelper.new.getServiceURL

	def getAddresses(customer_id)
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/1/address/list')
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		resultArray = Array.new

		decodedJSON.each do |c|
			resultArray.push(createAddressFromDecodedJSON(c))
		end

		return resultArray
	end

	private
	def createAddressFromDecodedJSON(decodedJSON)
		address = Address.new
		address.id = decodedJSON["id"]
		address.address = decodedJSON["address"]
		address.country = decodedJSON["country"]
		address.note = decodedJSON["note"]
		address.created = decodedJSON["created"]
		address.updated = decodedJSON["updated"]
		address.customerId = decodedJSON["customerId"]
		address.house = decodedJSON["house"]
		address.county = decodedJSON["county"]
		address.parish = decodedJSON["parish"]
		address.townCounty = decodedJSON["townCounty"]
		address.mobile = decodedJSON["mobile"]
		address.sms = decodedJSON["sms"]
		address.email = decodedJSON["email"]
		return address
	end

end