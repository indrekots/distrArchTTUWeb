class ContractsController < ApplicationController

  Rails.logger = Logger.new(STDOUT)
  
  def index
  	@contracts = ContractService.new.getContracts
  end

  def show
  	@contract = ContractService.new.getContract(params[:id])
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
  
    ContractService.new.addContract(contract)
  
  	#redirect_to contracts_path
    respond_to do |format|
      format.json {render :json => '{"head" : "Success",
                                     "body" : "A new contract has been created"
                                     }'}
    end
  end

end