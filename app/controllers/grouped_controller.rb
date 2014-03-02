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
end