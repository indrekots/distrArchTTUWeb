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
		@commDevice = @commDevicesService.getCommDevice(params[:id], params[:customerId])
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
		

		isSuccess = @commDevicesService.addCommDevice(commDevice, params[:customerId])

		if isSuccess
			respond_to do |format|
			  format.json {render :json => '{"head" : "Success",
			                                 "body" : "A new communication device has been created"
			                                 }'}
			end
		else
			sendAjaxErrorMessage
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
		

		isSuccess = @commDevicesService.addCommDevice(commDevice, params[:customerId])

		if isSuccess
			respond_to do |format|
			  format.json {render :json => '{"head" : "Success",
			                                 "body" : "Communication device has been updated"
			                                 }'}
			end
		else
			sendAjaxErrorMessage
		end
	end

	def destroy
		isSuccess = @commDevicesService.deleteCommDevice(params[:id], params[:customerId])

		if isSuccess
			respond_to do |format|
			  format.json {render :json => '{"head" : "Success",
			                                 "body" : "Communication device has been deleted",
			                                 "id" : ' + params[:id].to_s + '
			                                 }'}
			end
		else
			sendAjaxErrorMessage
		end
	end

	private
    def sendAjaxErrorMessage
	    respond_to do |format|
	        format.json {render :json => '{"head" : "Failure",
	                                       "body" : "Oops, something went wrong"
	                                       }',
	                            :status => 500}
    end
	end

end