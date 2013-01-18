class CommDevicesController < ApplicationController

	attr :commDevicesService, true

	def initialize
	    @commDevicesService = CommDevicesService.new
	    super
 	end
  
	def index
		@commDevices = @commDevicesService.getCommDevices(params[:customerId])
		@customerId = params[:customerId]
	end

	def show
		@commDevice = @commDevicesService.getcommDevice(params[:id], params[:customerId])
	end

	def new
		@commDevice = CommDevice.new
		@commDevice.customerId = params[:customerId]
	end

	def create
		commDevice = CommDevice.new
		
		commDevice.commDeviceType = params[:commDeviceType]
		commDevice.customerId = params[:customerId]
		commDevice.valueText = params[:valueText]
		commDevice.orderb = params[:orderb]
		commDevice.created = params[:created]
		

		@commDevicesService.addCommDevice(commDevice)

		respond_to do |format|
		  format.json {render :json => '{"head" : "Success",
		                                 "body" : "A new communication device has been created"
		                                 }'}
		end
	end

	def edit
		@commDevice = @commDevicesService.getCommDevice(params[:id], params[:customerId])
	end

	def update
		commDevice = CommDevice.new
		
		commDevice.commDeviceType = params[:commDeviceType]
		commDevice.customerId = params[:customerId]
		commDevice.valueText = params[:valueText]
		commDevice.orderb = params[:orderb]
		commDevice.created = params[:created]
		

		@commDevicesService.addCommDevice(commDevice)

		respond_to do |format|
		  format.json {render :json => '{"head" : "Success",
		                                 "body" : "Communication device has been updated"
		                                 }'}
		end
	end

	def destroy
		@commDevicesService.deleteCommDevice(params[:id], params[:customerId])

		respond_to do |format|
		  format.json {render :json => '{"head" : "Success",
		                                 "body" : "Communication device has been deleted",
		                                 "id" : ' + params[:id].to_s + '
		                                 }'}
		end
	end

end