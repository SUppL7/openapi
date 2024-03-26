# app/controllers/api/v1/registrations_controller.rb
class Api::V1::RegistrationsController < Devise::RegistrationsController
	skip_before_action :authenticate_any!
	respond_to :json

	def create
		build_resource(sign_up_params)

		if resource.save
			sign_up(resource_name, resource)
			render json: { token: generate_jwt(resource) }, status: :created
		else
			clean_up_passwords resource
			render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def sign_up_params
		params.require(:student).permit(:email, :password, :password_confirmation, :first_name, :last_name, :surname, :school_class_id, :school_id)
	end


	def generate_jwt(student)
		JWT.encode({ student_id: student.id }, Rails.application.credentials.jwt_secret_key, 'HS256')
	end
end
