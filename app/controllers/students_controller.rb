class StudentsController < ApplicationController

  def create
    @student = Student.create(student_params)
    if @student.save
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end


  def index
    @students = Student.where(class_id: params[:class_id])

    render json: @students, status: :ok
  end

  def show
    @student = Student.find(params[:id])
    render json: @student
  rescue ActiveRecord::RecordNotFound
    head :not_found, status: :bad_request
  end

  def destroy
    @student = Student.find(params[:id])
    unless @student.nil?
      @student.destroy
      head :no_content
    else
      render nothing: true, status: :not_found
    end
  end



  def student_params
    params.require(:student).permit(:first_name, :last_name, :surname, :school_class_id)
  end

end
