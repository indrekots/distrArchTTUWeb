class CustomersController < ApplicationController
  
  def index
  	@customers = CustomerService.new.getCustomers
  end

  def show
  	@customer = CustomerService.new.getCustomer(params[:id])
  end

  def new
  	@customer = Customer.new
  end
end
