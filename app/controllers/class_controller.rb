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
   		session[:err_msg][1] = "Course name cannot be blank."
	end
  	if params[:filename].blank? 
   		session[:err_msg][2] = "You need to import a file."
  	elsif File.extname(params[:file].original_filename) != ".csv"
   		session[:err_msg][3] = "You need to import a csv file."
	end
	
  	if params[:group_size].to_i <= 0 
   		session[:err_msg][4] = "Group size cannot less than 0."
	end

	if session[:err_msg][1].blank? && session[:err_msg][2].blank? && session[:err_msg][3].blank? & session[:err_msg][4].blank?
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
	else
   		redirect_to "/lecturer"
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
