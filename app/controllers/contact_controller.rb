class ContactController < ApplicationController
  def contact
  @students = Student.find(:all, :conditions => {:course_id => session[:course_id]})
  @students.each do |student|
  	ContactMailer.contact(student).deliver
  	end

  	redirect_to "/class/show/#{session[:course_id]}"
  end
end
