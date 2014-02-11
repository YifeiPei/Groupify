require 'Grouper'

class SortController < ApplicationController
  layout 'lecturer_application'
  
  def index
    @current_course = Course.find_by(id: session[:course_id])
    @sort = {}
  end

  def sort
    #render :text => 'in sort function'
    @existing_config = SortConfig.find_by(course_id: session[:course_id])
  	if @existing_config.blank?
      redirect_to '/sort/index'
    end
    if @existing_config.algorithm == 0
      #flash[:notice] = 'Random sort'
      sorter = Grouper::Random_sorter.new
    elsif @existing_config.algorithm == 1
      # Do evolutionary sort
    end
    
    # Get student list from csv file
    course = Course.find_by(id: session[:course_id])
    filename = course.filelocation
    source = "#{Rails.root}/uploads/" + filename 
    student_list = sorter.get_student_list_from_csv( source )

    # Set parameters
    group_size = @existing_config.group_size

    #render :text => group_size
    # Sort student list
    sorted_list = sorter.sort( student_list, group_size )

    # Store sorted list
    destination = "#{Rails.root}/uploads/" + filename + '-sorted.csv'
    sorter.write_group_numbers_to_csv( sorted_list, destination )

    redirect_to '/class/sorted'
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
       	sc.group_size = params[:group_size]
	   	end
    	
    	if @sort_config.save
      #	flash[:notice] = "Configuration saved."
      	flash[:color] = "valid"
    	else
       	flash[:notice] = "Configuration not saved."
       	flash[:color] = "invalid"
    	end
    else
   	 SortConfig.where(:course_id => session[:course_id]).update_all(course_id: session[:course_id], algorithm: params[:algorithm], age: params[:age], gpa: params[:gpa], degree: params[:degree])
    end
    # Run sort algorithm
    sort
    #redirect_to '/class/sorted'
  end
end
