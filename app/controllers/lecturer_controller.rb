class LecturerController < LecturerApplicationController
   layout 'lecturer_application'
  def index
    @courses = Course.where(user_id: session[:user_id])
  end
	def delete
	    @current_course = Course.find_by(user_id: session[:user_id], id: params[:id])
	    Student.destroy_all(:course_id => @current_course.id)
	    Scg.destroy_all(:course_id => @current_course.id)
	    Group.destroy_all(:course_id => @current_course.id)
		@current_course.destroy
		render "index"
	end

  def logout
  	reset_session
  	redirect_to "/"
  end
end