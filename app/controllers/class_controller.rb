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
   	if params[:course][:name].blank?
   		session[:err_msg1] = "Course name cannot be blank."
	end
  	if params[:file].blank? 
   		session[:err_msg2] = "You need to import a file."
  	elsif File.extname(params[:file].original_filename) != ".csv"
   		session[:err_msg2] = "You need to import a csv file."
	end
	
  	if params[:group_size].to_i <= 0 
   		session[:err_msg4] = "Group size cannot less than 0."
	end

  	if params[:course][:name].blank? || params[:file].blank? || params[:group_size].to_i <= 0 || File.extname(params[:file].original_filename) != ".csv"
  		redirect_to "/lecturer"
	else
   	 	@course = Course.new do |c|
    		c.name = params[:course][:name]
      		c.user_id = session[:user_id]
    	end
    	if @course.save
    	#  flash[:notice] = "Course added."
      	flash[:color] = "valid"
      	session[:course_id] = @course.id
      	Student.import(params[:file], @course.id)
    	@sort_config = SortConfig.new do |sc|
    		sc.course_id = session[:course_id]
    		sc.group_size = params[:group_size]
    	end
    	@sort_config.save
		redirect_to "/sort/sort"
	    else
			redirect_to "/lecturer"
   		end
   	end
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
	@students = Student.find(:all, :order => "group_id", :conditions => {:course_id => session[:course_id]})
   render 'show'
  end

end
