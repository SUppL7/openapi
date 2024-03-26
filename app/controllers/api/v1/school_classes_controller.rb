class Api::V1::SchoolClassesController < Api::V1::ApplicationController
  def index
    classes = SchoolClass.where(school_id: params[:school_id])

    render json: classes, status: :ok
  end

  def get_class_student_list
    students = Student.where(class_id: params[:school_class_id])
    render json: students, status: :ok
  end
end
