class Api::V1::ApplicationController < ActionController::Base
	before_action :authenticate_any!

	def authenticate_any!
	end
end