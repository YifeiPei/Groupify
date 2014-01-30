class ClassController < ApplicationController
  def index

  end

  def add_course
    
  end

  def new

  end

  def create
    @course = Course.new do |c|
      c.name = params[:course][:name]
      c.user_id = session[:user_id]
    end
    if @course.save
      flash[:notice] = "Course added."
      flash[:color] = "valid"
    else
       flash[:notice] = "Course not added."
       flash[:color] = "invalid"
    end
  end

  def show
     @current_course = Course.find_by(user_id: session[:user_id], name: params[:id])
    #flash[:notice] = @current_course.inspect

    # Load csv file and create list of students
    # Retrieve file from db, this depends on the upload file implementation
    # and will be written once that has been merged in.

    if @current_course.filelocation != nil
      # Parse file into list of students
     # @student_list = []
     # CSV.foreach(@current_course.filelocation) do |row|
     #   student = Student.new (row[0], row[1], row[2])
     #   @student_list << student
     # end
    #else
    #  @student_list = nil
    end
  #end
  end

end
