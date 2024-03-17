class SchoolClassesController < ApplicationController
  def index
    @classes = SchoolClass.where(school_id: params[:school_id])
    render json: @classes, status: :ok
  end

  def getClassStudentList
    @students = Student.where(class_id: params[:class_id])
    render json: @students, status: :ok
  end

end
