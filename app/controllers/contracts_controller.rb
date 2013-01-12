class ContractsController < ApplicationController

  Rails.logger = Logger.new(STDOUT)

  attr :contractService, true

  def initialize
    @contractService = ContractService.new
    super
  end
  
  def index
  	@contracts = @contractService.getContracts
  end

  def show
  	@contract = @contractService.getContract(params[:id])
  end
  
  def new
  	@contract = Contract.new
  end
  
  def create
  	contract = Contract.new
  	contract.name = params[:name]
    contract.description = params[:description]
    contract.note = params[:note]
    contract.contractNumber = params[:contractNumber]
    contract.validFrom = params[:validFrom]
    contract.validTo = params[:validTo]
    contract.parentContractId = params[:parentConractId]
    contract.conditions = params[:conditions]
  
    @contractService.addContract(contract)
  
  	#redirect_to contracts_path
    respond_to do |format|
      format.json {render :json => '{"head" : "Success",
                                     "body" : "A new contract has been created"
                                     }'}
    end
  end

  def edit
    @contract = @contractService.getContract(params[:id])
  end

  def update
    contract = @contractService.getContract(params[:id])

    contract.name = params[:name]
    contract.description = params[:description]
    contract.note = params[:note]
    contract.contractNumber = params[:contractNumber]
    contract.validFrom = params[:validFrom]
    contract.validTo = params[:validTo]
    contract.parentContractId = params[:parentConractId]
    contract.conditions = params[:conditions]

    @contractService.addContract(contract)

    respond_to do |format|
      format.json {render :json => '{"head" : "Success",
                                     "body" : "Contract has been updated"
                                     }'}
    end
  end

  def destroy
    @contractService.deleteContract(params[:id])

    respond_to do |format|
      format.json {render :json => '{"head" : "Success",
                                     "body" : "Contract has been deleted",
                                     "id" : ' + params[:id].to_s + '
                                     }'}
    end
  end

end