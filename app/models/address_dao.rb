require 'rubygems'
require 'httparty'
require "active_support"

class AddressDAO

	BASE_SERVICE_URL = ServiceHelper.new.getServiceURL

	def getAddresses(customerId)
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/address/list')
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		resultArray = Array.new

		decodedJSON.each do |c|
			resultArray.push(createAddressFromDecodedJSON(c))
		end

		return resultArray
	end

	def getAddress(id, customerId)
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/address/' + id.to_s)
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		return createAddressFromDecodedJSON(resultJSON)
	end

	def addAddress(address, customerId)
		if address.id.nil?
			return addNewAddress(address, customerId)
		else
			return addExistingAddress(address, customerId)
		end
	end

	def deleteAddress(id, customerId)
		response = HTTParty.delete(BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/address/' + id.to_s,
			:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
		return response
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

	def addNewAddress(address, customerId)
		Rails.logger.info BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/address/'
		response = HTTParty.post(BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/address/', :query => {
				:address => address.address,
				:country => address.country,
				:note => address.note,
				:customerId => address.customerId,
				:house => address.house,
				:county => address.county,
				:parish => address.parish,
				:townCounty => address.townCounty,
				:mobile => address.mobile,
				:phone => address.phone,
				:sms => address.sms,
				:email => address.email
				},
				:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
		return response
	end

	def addExistingAddress(address, customerId)
		response = HTTParty.put(BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/address/' + address.id.to_s, :query => {
				:address => address.address,
				:country => address.country,
				:note => address.note,
				:customerId => address.customerId,
				:house => address.house,
				:county => address.county,
				:parish => address.parish,
				:townCounty => address.townCounty,
				:mobile => address.mobile,
				:phone => address.phone,
				:sms => address.sms,
				:email => address.email
				},
				:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
		return response
	end

end