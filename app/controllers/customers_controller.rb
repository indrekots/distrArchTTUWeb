class CustomersController < ApplicationController
  def index
  	@customer = CustomerService.new.getCustomer(1)
  end
end
