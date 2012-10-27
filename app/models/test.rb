require 'rubygems'
require 'httparty'

class Resttest
	include HTTParty
	base_uri 'localhost/yepify'

end