class GeneralService

	def isSuccess(response)
		return !checkResponseForErrors(response)
	end

	private
	def checkResponseForErrors(response)
		Rails.logger.info "Response HTTP status code: " + response.code.to_s
		if response.code >= 200 && response.code < 300
			return false
		else
			return true
		end
	end
end