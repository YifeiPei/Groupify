require 'csv'

class GroupedController < LecturerApplicationController
  layout 'lecturer_application'
  def index
    if params[:id]
      @current_course = Course.find_by(user_id: session[:user_id], id: params[:id])
      session[:course_id] = @current_course.id
    else
      @current_course = Course.find_by(id: session[:course_id])
    end
      @group_count = Student.where(:course_id => @current_course.id).distinct.count(:group_id)
      @old_size = SortConfig.find_by(:course_id => @current_course.id).group_size
 #	  @unsort_students = Student.find(:all, :conditions => {:course_id => session[:course_id], :group_id => nil})
  end
  
  def export_csv
    @current_course = Course.find_by(user_id: session[:user_id], id: session[:course_id])
	@students = Student.find(:all, :order => "group_id", :conditions => {:course_id => session[:course_id]})
	csv_string = CSV.generate do |csv|
		csv << ["Student ID", "First Name", "Last Name", "Degree", "Group Number"]
		@students.each do |student|
			csv << [student.student_id, student.first_name, student.last_name, student.degree, Group.where(:id => student.group_id).first.number]
		end
	end
	send_data csv_string, :type => "text/csv; charset=iso-8859-1; header=present", :disposition => "attachment; filename=#{@current_course.name}.csv"
  end
  
    def add_student
     @current_course = Course.find_by(user_id: session[:user_id], id: session[:course_id])
   	if params[:student][:student_id].blank?
   		session[:err_msg][1] = "Student id cannot be blank."
	end
   	if params[:student][:first_name].blank?
   		session[:err_msg][2] = "Student first name cannot be blank."
	end
	
   	if params[:student][:last_name].blank?
   		session[:err_msg][3] = "Student last name cannot be blank."
	end

	if session[:err_msg][1].blank? && session[:err_msg][2].blank? && session[:err_msg][3].blank? & session[:err_msg][4].blank?
     	student = Student.find_by(:student_id => params[:student][:student_id], :course_id => @current_course.id) || Student.new
    	student.student_id = params[:student][:student_id]
    	student.first_name = params[:student][:first_name]
    	student.last_name = params[:student][:last_name]
    	student.degree = params[:student][:degree]
    	student.course_id = @current_course.id
    	student.email = "#{student.student_id}@student.adelaide.edu.au"
    	scg = Scg.new
    	scg.student_id = params[:student][:id]
    	scg.course_id = @current_course.id
    	if !params[:group_number].blank?
    		group = Group.find_by(:course_id => @current_course.id, :number => params[:group_number]) || Group.new
   		 	group.number = params[:group_number]
        	group.course_id = @current_course.id
    		group.save!
    		scg.group_id = group.id
    		student.group_id = group.id
    	end
    	scg.save!
    	student.scgs << scg
  	 	student.save!
  	 	redirect_to "/grouped"

	else
   		redirect_to "/grouped"
   	end
  end
  
  def drop_update
    @current_course = Course.find_by(user_id: session[:user_id], id: session[:course_id])
  	@student = Student.find(params[:student_id])
  	@scg = Scg.find_by(:student_id => params[:student_id], :course_id => @current_course.id)  
	@student.update_all(group_id: params[:group_id])
	@scg.update_all(group_id: params[:group_id])
  end
end