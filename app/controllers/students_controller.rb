class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.all
  end

  
  def show
  end


  def new
    @student = Student.new
    
  end
  
  def create
    
    existing_student = Student.find_by(name: student_params[:name], subject_name: student_params[:subject_name])
    
    if existing_student
      
      existing_student.update(marks: existing_student.marks + student_params[:marks].to_i)
      redirect_to root_path, notice: 'Student marks were successfully updated.'
    else
    
      @student = Student.new(student_params)
      
      if @student.save
        redirect_to root_path, notice: 'Student was successfully created.'
      else
        render partial: 'form', locals: { student: @student }, status: :unprocessable_entity
      end
    end
  end

  
  def edit
  end


  def update
    if @student.update(student_params)
      redirect_to root_path, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  
  def destroy
    @student.destroy
    redirect_to root_path, notice: 'Student was successfully deleted.'
  end
  
  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:name, :subject_name, :marks)
    end
  end
  