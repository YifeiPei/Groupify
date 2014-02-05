class LecturerController < LecturerApplicationController
   layout 'lecturer_application'
     def index
    @courses = Course.where(user_id: session[:user_id])
  end
    def logout
		session[:user_id] = nil
		redirect_to "/"
	end
end
