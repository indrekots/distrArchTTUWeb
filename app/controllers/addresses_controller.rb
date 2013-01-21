class AddressesController < ApplicationController

	attr :addressService, true

	def initialize
		@addressService = AddressService.new
		super
	end

	def index
		@addresses = @addressService.getAddresses(params[:customerId])
		@customerId = params[:customerId]
	end

	def show
		@address = @addressService.getAddress(params[:id], params[:customerId])
	end

	def new
		@address = Address.new
		@address.customerId = params[:customerId]
	end

	def create
		address = Address.new
		address.address = params[:address]
		address.country = params[:country]
		address.note = params[:note]
		address.house = params[:house]
		address.county = params[:county]
		address.parish = params[:parish]
		address.townCounty = params[:townCounty]
		address.mobile = params[:mobile]
		address.phone = params[:phone]
		address.sms = params[:sms]
		address.email = params[:email]
		address.customerId = params[:customerId]

		isSuccess = @addressService.addAddress(address, params[:customerId])

		if isSuccess
			respond_to do |format|
		      format.json {render :json => '{"head" : "Success",
		                                     "body" : "A new address has been created"
		                                     }'}
		    end
	    else
	    	sendAjaxErrorMessage
    	end
	end

	def edit
		@address = @addressService.getAddress(params[:id], params[:customerId])
	end

	def update
		address = @addressService.getAddress(params[:id], params[:customerId])
	  
	    address.address = params[:address]
		address.country = params[:country]
		address.note = params[:note]
		address.house = params[:house]
		address.county = params[:county]
		address.parish = params[:parish]
		address.townCounty = params[:townCounty]
		address.mobile = params[:mobile]
		address.phone = params[:phone]
		address.sms = params[:sms]
		address.email = params[:email]
		address.customerId = params[:customerId]

		isSuccess = @addressService.addAddress(address, params[:customerId])

		if isSuccess
		    respond_to do |format|
		      format.json {render :json => '{"head" : "Success",
		                                     "body" : "Address has been updated"
		                                     }'}
	    	end
    	else
    		sendAjaxErrorMessage
		end
	end

	def destroy
    isSuccess = @addressService.deleteAddress(params[:id], params[:customerId])

    if isSuccess
	    respond_to do |format|
	      format.json {render :json => '{"head" : "Success",
	                                     "body" : "Address has been deleted",
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