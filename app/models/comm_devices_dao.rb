require 'rubygems'
require 'httparty'
require "active_support"

class CommDevicesDAO

	BASE_SERVICE_URL = ServiceHelper.new.getServiceURL

	def getCommDevices(customerId)
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/1/device/list')
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
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/1/device/1')
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		commDevice = createCommDeviceFromDecodedJSON(resultJSON)
		commDevice.customerId = customerId
	end

	def addCommDevice(commDevice)
		if commDevice.id.nil?
			addNewCommDevice(commDevice)
		else
			addExistingCommDevice(commDevice)
		end
	end

	def deleteCommDevice(id, customerId)
		response = HTTParty.delete(BASE_SERVICE_URL + '/customer/1/device/1',
			:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
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

	def addNewCommDevice(commDevice)
		response = HTTParty.post(BASE_SERVICE_URL + '/customer/1/device/', :query => {
				:created => commdevice.created,
				:value => commDevice.valueText,
				:order => commDevice.orderb
				},
				:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
	end

	def addExistingCommDevice(commDevice)
		response = HTTParty.put(BASE_SERVICE_URL + '/customer/1/device/1', :query => {
				:created => commdevice.created,
				:value => commDevice.valueText,
				:order => commDevice.orderb
				},
				:headers => {
					"content_type" => "application/json;charset=utf_8"
				})
		Rails.logger.info response
	end

end