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
end
