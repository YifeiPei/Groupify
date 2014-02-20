require 'csv'

class GroupedController < LecturerApplicationController
  layout 'lecturer_application'
  def index
    @current_course = Course.find(session[:course_id])
    @group_count = Student.where(:course_id => @current_course.id).distinct.count(:group_id)
  end
end
