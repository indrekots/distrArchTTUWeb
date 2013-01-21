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

    isSuccess = @customerService.addCustomer(customer)

    if isSuccess
      respond_to do |format|
        format.json {render :json => '{"head" : "Success",
                                       "body" : "A new customer has been created"
                                       }'}
      end
    else
      sendAjaxErrorMessage
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

    isSuccess = @customerService.addCustomer(customer)

    if isSuccess
      respond_to do |format|
        format.json {render :json => '{"head" : "Success",
                                       "body" : "Customer has been updated"
                                       }'}
      end
    else
      sendAjaxErrorMessage
    end
  end

  def destroy
    isSuccess = @customerService.deleteCustomer(params[:id])

    if isSuccess
      respond_to do |format|
        format.json {render :json => '{"head" : "Success",
                                       "body" : "Customer has been deleted",
                                       "id" : ' + params[:id].to_s + '
                                       }'}
      end
    else
      sendAjaxErrorMessage
    end
  end

  def search
    responseBody = @customerService.search(params[:firstName])

    respond_to do |format|
        format.json {render :json => responseBody}
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
