require 'rubygems'
require 'httparty'
require "active_support"

class CommDevicesDAO

	BASE_SERVICE_URL = ServiceHelper.new.getServiceURL

	def getCommDevices(customerId)
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/device/list')
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		resultArray = Array.new

		decodedJSON.each do |c|
			commDevice = createCommDeviceFromDecodedJSON(c)
			commDevice.customerId = customerId
			resultArray.push(commDevice)
		end

		return resultArray
	end

	def getCommDevice(id, customerId)
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/device/' + id.to_s)
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		commDevice = createCommDeviceFromDecodedJSON(resultJSON)
		commDevice.customerId = customerId

		return commDevice
	end

	def addCommDevice(commDevice, customerId)
		if commDevice.id.nil?
			return addNewCommDevice(commDevice, customerId)
		else
			return addExistingCommDevice(commDevice, customerId)
		end
	end

	def deleteCommDevice(id, customerId)
		response = HTTParty.delete(BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/device/' + id.to_s,
			:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
		return response
	end

	private
	def createCommDeviceFromDecodedJSON(decodedJSON)
		commDevice = CommDevice.new
		
		commDevice.id = decodedJSON["id"]
		commDevice.valueText = decodedJSON["value"]
		commDevice.orderb = decodedJSON["order"]
		commDevice.created = decodedJSON["created"]

		return commDevice
	end

	def addNewCommDevice(commDevice, customerId)
		response = HTTParty.post(BASE_SERVICE_URL + '/customer/' + customerId.to_s + '/device/', :query => {
				:created => commDevice.created,
				:value => commDevice.valueText,
				:order => commDevice.orderb
				},
				:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
		return response
	end

	def addExistingCommDevice(commDevice, customerId)
		response = HTTParty.put(BASE_SERVICE_URL + '/customer/' + customerId + '/device/' + commDevice.id.to_s, :query => {
				:created => commdevice.created,
				:value => commDevice.valueText,
				:order => commDevice.orderb
				},
				:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
		return response
	end

end