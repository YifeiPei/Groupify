class LecturerApplicationController < ApplicationController

  before_action :generate_courses  
protected

  def generate_courses
    @courses = Course.where(user_id: session[:user_id])
  end
end