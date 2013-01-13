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

		@addressService.addAddress(address)

		respond_to do |format|
	      format.json {render :json => '{"head" : "Success",
	                                     "body" : "A new address has been created"
	                                     }'}
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

		@addressService.addAddress(address)

	    respond_to do |format|
	      format.json {render :json => '{"head" : "Success",
	                                     "body" : "Address has been updated"
	                                     }'}
    	end
	end

	def destroy
    @addressService.deleteAddress(params[:id], params[:customerId])

    respond_to do |format|
      format.json {render :json => '{"head" : "Success",
                                     "body" : "Address has been deleted",
                                     "id" : ' + params[:id].to_s + '
                                     }'}
    end
  end

end