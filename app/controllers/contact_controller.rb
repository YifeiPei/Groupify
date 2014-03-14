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
    threads = []
    process = fork do
      for i in 1..@group_count
        body = "Hi! You are enrolled in #{@current_course.name}. You have been allocated to group #{i}.\n\n The course administrator has engaged Groupify to allocate you to a group. You can contact us via our website at www.groupify.com.au. We have been given your information for the purpose of forming groups and providing contact between you and the lecturer. If we didn't receive your information, group formation would take a lot longer for everyone. We won't disclose your information to anyone. If you would like to make a complaint please contact us at contact@groupify.com.au."
		    @group_emails = []
		    @students = Student.find(:all, :conditions => {:course_id => @current_course.id, :group_id => Group.find_by(:course_id => @current_course.id, :number => i).id})
        @students.each do |student|
          @group_emails << student.email
  			end
				ContactMailer.contact(@current_user.email, @group_emails, "You are in Group #{i} for #{@current_course.name}", body).deliver
      end
      Process.kill("HUP") 
    end
    Process.detach(process)
    threads.each(&:join)
    @current_course.confirmed = true
    @current_course.save
   	redirect_to "/grouped/index/#{session[:course_id]}"
  end
  
  def notify_new_student(student_id)
   
  end
   
  def notify_moved_student(student_id)
   
  end  
end
