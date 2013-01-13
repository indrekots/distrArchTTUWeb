class CustomersController < ApplicationController

  attr :cutomerService, true

  def initialize
    @customerService = CustomerService.new
    super
  end
  
  def index
  	@customers = @customerService.getCustomers
  end

  def show
  	@customer = @customerService.getCustomer(params[:id])
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

  	Rails.logger.info customer.firstName
    Rails.logger.info customer.lastName
    Rails.logger.info customer.identityCode
    Rails.logger.info customer.cstType
    Rails.logger.info customer.birthDate

    @customerService.addCustomer(customer)

  	#redirect_to customers_path
    respond_to do |format|
      format.json {render :json => '{"head" : "Success",
                                     "body" : "A new customer has been created"
                                     }'}
    end
  end

  def edit
    @customer = @customerService.getCustomer(params[:id])
  end

  def update
    customer = @customerService.getCustomer(params[:id])

    customer.firstName = params[:firstName]
    customer.lastName = params[:lastName]
    customer.identityCode = params[:identityCode]
    customer.cstType = params[:cstType]
    customer.birthDate = params[:birthDate]

    @customerService.addCustomer(customer)

    respond_to do |format|
      format.json {render :json => '{"head" : "Success",
                                     "body" : "Customer has been updated"
                                     }'}
    end
  end

  def destroy
    @customerService.deleteCustomer(params[:id])

    respond_to do |format|
      format.json {render :json => '{"head" : "Success",
                                     "body" : "Customer has been deleted",
                                     "id" : ' + params[:id].to_s + '
                                     }'}
    end
  end
end
