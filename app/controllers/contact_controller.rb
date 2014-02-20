class ContactController < ApplicationController
  layout 'lecturer_application'

  def contact
	@students = Student.find(:all, :conditions => {:course_id => session[:course_id]})
      @current_course = Course.find_by(user_id: session[:user_id], id: session[:course_id])
  end
  def send_email
    @students = Student.find(:all, :conditions => {:course_id => session[:course_id]})
	@student_emails = []
 	 @students.each do |student|
 	 @student_emails << student.email
  	end
  	 @current_user = User.find(session[:user_id]) 

  	ContactMailer.contact(@current_user.email, @student_emails, params[:subject], params[:message]).deliver

  	redirect_to "/class/show/#{session[:course_id]}"
  end
  
end
