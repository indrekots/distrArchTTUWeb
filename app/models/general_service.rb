class GeneralService

	def isSuccess(response)
		return !checkResponseForErrors(response)
	end

	private
	def checkResponseForErrors(response)
		if response.code != 200
			return true
		else
			return false
		end
	end
end