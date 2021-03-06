require 'rubygems'
require 'httparty'
require "active_support"

class CustomerDAO
	BASE_SERVICE_URL = ServiceHelper.new.getServiceURL

	def getCustomers
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/list')
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		resultArray = Array.new

		decodedJSON.each do |c|
			resultArray.push(createCustomerFromDecodedJSON(c))
		end

		return resultArray
	end

	def getCustomer(id)
		resultJSON = HTTParty.get(BASE_SERVICE_URL + '/customer/' + id.to_s)
		decodedJSON = ActiveSupport::JSON.decode(resultJSON.response.body)

		return createCustomerFromDecodedJSON(resultJSON)
	end

	def addCustomer(customer)
		if customer.id.nil?
			return addNewCustomer(customer)
		else
			return addExistingCustomer(customer)
		end
	end

	def deleteCustomer(id)
		response = HTTParty.delete(BASE_SERVICE_URL + '/customer/' + id.to_s,
			:headers => {
					"content-type" => "application/json;charset=utf-8"
				})
		Rails.logger.info response
		return response
	end

	def search(firstName)
		res = HTTParty.get(BASE_SERVICE_URL + '/customer/search',
			:query => {
				:firstname => firstName
				},
			:headers => {
				"content-type" => "application/json;charset=utf-8"
				})
		Rails.logger.info res.request
		Rails.logger.info res
		return res.response.body
	end

	private
	def addNewCustomer(customer)
		response = HTTParty.post(BASE_SERVICE_URL + '/customer',
			:body => {
				:firstName => customer.firstName,
				:lastName => customer.lastName,
				:identityCode => customer.identityCode,
				:note => customer.note,
				:birthDate => customer.birthDate,
				:created => customer.createdBy,
				:updated => customer.updatedBy
				#:customerAddress => "null"
				}.to_json,
			:headers => {
					"content-type" => "application/json;charset=utf-8"
				})
		Rails.logger.info response
		return response
	end

	private
	def addExistingCustomer(customer)
		response = HTTParty.put(BASE_SERVICE_URL + '/customer/' + customer.id.to_s, 
			:body => {
				:firstName => customer.firstName,
				:lastName => customer.lastName,
				:identityCode => customer.identityCode,
				:note => customer.note,
				:birthDate => customer.birthDate,
				:created => customer.createdBy,
				:updated => customer.updatedBy
				#:customerAddress => "null"
				}.to_json,
			:headers => {
					"content-type" => "application/json;charset=utf-8"
				})
		Rails.logger.info response

		return response
	end

	private
	def createCustomerFromDecodedJSON(decodedJSON)
		customer = Customer.new
		customer.id = decodedJSON["id"]
		customer.cstType = decodedJSON["cstType"]
		customer.cstStateType = decodedJSON["cstStateType"]
		customer.firstName = decodedJSON["firstName"]
		customer.lastName = decodedJSON["lastName"]
		customer.identityCode = decodedJSON["identityCode"]
		customer.note = decodedJSON["note"]
		customer.birthDate = decodedJSON["birthDate"]
		customer.created = decodedJSON["updated"]
		customer.createdBy = decodedJSON["createdBy"]
		customer.updatedBy = decodedJSON["updatedBy"]
		return customer
	end

end