class LecturerController < ApplicationController
  def index
    @courses = Course.where(user_id: session[:user_id])
  end
  
end
