class ContractsController < ApplicationController
  
  def index
  	@contracts = ContractService.new.getContracts
  end

  def show
  	@contract = ContractService.new.getContract(params[:id])
  end
  
  def new
  	@contract = Contract.new
  end
  
  #def create
  #	customer = Customer.new
  #	#Rails.logger.info params[:firstName]
  #	customer.firstName = params[:firstName]
  #	customer.lastName = params[:lastName]
  # customer.identityCode = params[:identityCode]
  #  customer.cstType = params[:cstType]
  #  customer.birthDate = params[:birthDate]
  #
  #	Rails.logger.info customer.firstName
  # Rails.logger.info customer.lastName
  #  Rails.logger.info customer.identityCode
  #  Rails.logger.info customer.cstType
  #  Rails.logger.info customer.birthDate
  #
  #  CustomerService.new.addCustomer(customer)
  #
  #	#redirect_to customers_path
  # respond_to do |format|
  #    format.json {render :json => '{"head" : "Success",
  #                                   "body" : "A new customer has been created"
  #                                   }'}
  #  end
  #end

end