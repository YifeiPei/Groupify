class LecturerController < ApplicationController
  layout 'lecturer_application'
  
  def index
    @courses = Course.where(user_id: session[:user_id])
  end
  
end
