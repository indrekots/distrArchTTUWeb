class CommDevicesService < GeneralService

	attr :commDeviceDAO, true

	def initialize
		@commDevicesDAO = CommDevicesDAO.new
	end

	def getCommDevices(customerId)
		@commDevicesDAO.getCommDevices(customerId)
	end

	def getCommDevice(id, customerId)
		@commDevicesDAO.getCommDevice(id, customerId)
	end

	def addCommDevice(commDevice, customerId)
		response = @commDevicesDAO.addCommDevice(commDevice, customerId)
		return isSuccess(response)
	end

	def deleteCommDevice(id, customerId)
		response = @commDevicesDAO.deleteCommDevice(id, customerId)
		return isSuccess(response)
	end

end