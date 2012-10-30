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

  def create
  	customer = Customer.new
  	#Rails.logger.info params[:firstName]
  	customer.firstName = params[:firstName]
  	customer.lastName = params[:lastName]
    customer.identityCode = params[:identityCode]
    customer.cstType = params[:cstType]
    customer.birthDate = params[:birthDate]

    Rails.logger.info "ajee"
  	Rails.logger.info customer.firstName
    Rails.logger.info customer.lastName
    Rails.logger.info customer.identityCode
    Rails.logger.info customer.cstType
    Rails.logger.info customer.birthDate

  	#redirect_to customers_path
    respond_to do |format|
      format.json {render :json => "{head: 'Success'}"}
    end
  end
end
