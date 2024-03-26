class Api::V1::StudentsController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    student = Student.new(student_params)

    if student.save
      render json: student, status: :created
    else
      render json: { error: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
    head :no_content
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :surname, :school_class_id, :school_id)
  end
end
