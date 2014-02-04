class SortController < ApplicationController
  def index
    @current_course = Course.find_by(id: session[:course_id])
    @sort = {}
  end

  def sort
    
  end
  
  def save_config  
  	@existing_config = SortConfig.find_by(course_id: session[:course_id])
  	if @existing_config.blank?
    	@sort_config = SortConfig.new do |sc|
      	sc.course_id = session[:course_id]
      	sc.algorithm = params[:algorithm]
      	sc.age = params[:age]
      	sc.gpa = params[:gpa]
      	sc.degree = params[:degree]
    	end
    	
    	if @sort_config.save
      	flash[:notice] = "Course added."
      	flash[:color] = "valid"
    	else
       	flash[:notice] = "Course not added."
       	flash[:color] = "invalid"
    	end
    else
   	 SortConfig.where(:course_id => session[:course_id]).update_all(course_id: session[:course_id], algorithm: params[:algorithm], age: params[:age], gpa: params[:gpa], degree: params[:degree])
    end
    render "index"
  end
end
