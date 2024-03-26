class Api::V1::SessionsController < ::Devise::SessionsController
	before_action :authenticate_student!, only: [:destroy]

	def create
		student = Student.find_by(email: params[:email])

		if student && student.valid_password?(params[:password])
			render json: { token: generate_jwt(student) }
		else
			render json: { error: 'Invalid email or password' }, status: :unauthorized
		end
	end

	def destroy
		sign_out(current_student)
		render json: { message: 'Logged out successfully' }
	end

	private

	def generate_jwt(student)
		JWT.encode({ student_id: student.id }, Rails.application.credentials.jwt_secret_key, 'HS256')
	end
end
