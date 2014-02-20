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
  def notify_group
  	 @current_course = Course.find_by(id: session[:course_id])
    @group_count = Student.where(:course_id => @current_course.id).distinct.count(:group_id)
	 for i in 1..@group_count 
		@group_emails = []
		  @students = Student.find(:all, :conditions => {:course_id => @current_course.id, :group_id => Group.find_by(:course_id => @current_course.id, :number => i).id})
 	 		@students.each do |student|
 	 		@group_emails << student.email
  			end
	  	ContactMailer.contact(@current_user.email, @group_emails, "Group fromed notification for Group #{i}", "bla bla bla").deliver
	 end
	 @current_course.confirmed = true
	 @current_course.save
   	redirect_to "/grouped/index/#{session[:course_id]}"
  end
  
  
end
