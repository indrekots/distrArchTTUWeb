class AddressesController < ApplicationController

	attr :addressService, true

	def initialize
		@addressService = AddressService.new
		super
	end

	def index
		@addresses = @addressService.getAddresses(params[:id])
	end

end