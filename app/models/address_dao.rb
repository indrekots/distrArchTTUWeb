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

	def getAddress(id, customerId)
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/1/address/1')
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		return createAddressFromDecodedJSON(resultJSON)
	end

	def addAddress(address)
		if address.id.nil?
			addNewAddress(address)
		else
			addExistingAddress(address)
		end
	end

	def deleteAddress(id, customerId)
		response = HTTParty.delete(BASE_SERVICE_URL + '/customer/1/address/1',
			:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
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

	def addNewAddress(address)
		Rails.logger.info BASE_SERVICE_URL + '/customer/1/address/'
		response = HTTParty.post(BASE_SERVICE_URL + '/customer/1/address/', :query => {
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
	end

	def addExistingAddress(address)
		response = HTTParty.put(BASE_SERVICE_URL + '/customer/1/address/2', :query => {
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
	end

end