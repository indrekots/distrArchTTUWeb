class CommDevicesService

	attr :commDeviceDAO, true

	def initialize
		@commDevicesDAO = commDevicesDAO.new
	end

	def getCommDevices(customer_id)
		@commDevicesDAO.getCommDevices(customer_id)
	end

	def getCommDevice(id, customer_id)
		@commDevicesDAO.getCommDevice(id, customer_id)
	end

	def addCommDevice(address)
		@commDevicesDAO.addCommDevice(address)
	end

	def deleteCommDevice(id, customer_id)
		@commDevicesDAO.deleteCommDevice(id, customer_id)
	end

end