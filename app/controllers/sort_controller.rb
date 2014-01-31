class SortController < ApplicationController
  def index
    @current_course = Course.find_by(user_id: session[:user_id], name: params[:name])
    @sort = {}
  end

  def sort
    
  end
end
