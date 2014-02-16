require 'csv'

class ClassController < LecturerApplicationController
  layout 'lecturer_application'
  
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
    #  flash[:notice] = "Course added."
      flash[:color] = "valid"
    else
       flash[:notice] = "Course not added."
       flash[:color] = "invalid"
    end
	redirect_to "/lecturer"
  end

  def show
    if params[:id]
      @current_course = Course.find_by(user_id: session[:user_id], id: params[:id])
      session[:course_id] = @current_course.id
    else
      @current_course = Course.find_by(id: session[:course_id])
    end
   
     @students = Student.find(:all, :conditions => {:course_id => session[:course_id]})

    #render 'show'
  
  end

  def sorted
   	@current_course = Course.find_by(id: session[:course_id])
	@students = Student.find(:all, :conditions => {:course_id => session[:course_id]})
   render 'show'
  end

end
