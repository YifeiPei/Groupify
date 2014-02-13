require 'Grouper'

class SortController < ApplicationController
  layout 'lecturer_application'
  
  def index
    @current_course = Course.find_by(id: session[:course_id])
    @sort = {}
  end

  def sort
    # Check if course is already grouped
   
    @existing_config = SortConfig.find_by(course_id: session[:course_id])
  	if @existing_config.blank?
      redirect_to '/sort/index'
    end
    if @existing_config.algorithm == 0
      #flash[:notice] = 'Random sort'
      sorter = Grouper::Random_sorter.new
    elsif @existing_config.algorithm == 1
      # Do evolutionary sort
      sorter = Grouper::Random_sorter.new
    else
      sorter = Grouper::Random_sorter.new
    end
    
    # Get student list from csv file
    course = Course.find_by(id: session[:course_id])
    if course.filelocation
      filename = course.filelocation
      source = "#{Rails.root}/uploads/" + filename
      student_list = sorter.get_student_list_from_csv( source )
    else
    # Get student list from db
      student_list = sorter.get_student_list_from_db( session[:course_id] )
    end

    # Set parameters
    group_size = @existing_config.group_size
    
    # Find out number of students in course
    total_students = student_list.length
    # Calculate number of groups
    number_of_groups = total_students / group_size
    # Create new groups in groups table
    groups = []
    for count in 0...number_of_groups do
      groups << Group.new do |group|
        group.number = count + 1
      end
      groups[count].save
    end
    # Sort students into groups
    group_numbers = []

  	for counter in 0...total_students
    	group_numbers[counter] = []
    	group_numbers[counter][0] = counter + 1
  	end
  	group_numbers.shuffle!

  	i = 1
  	group_numbers.map! do |student|
      student << i
    	unless i == number_of_groups
      	i += 1
    	else i = 1
    	end
    	student
  	end

  	group_numbers.sort! {|a, b| a[0].to_i <=> b[0].to_i }

    update_info = {}
    # Iterate through students
    student_list.each_with_index do |student, index|

    scg = Scg.where(student_id: student.id, course_id: student.course_id).take
    group = groups[group_numbers[index][1]-1]
    item = {"group_id" => group.id}

    # The following command didn't work
    #scg.update(group_id: group.id)

    scg.group_id = group.id
    scg.save

    #update_info[scg.id] = item
    end
    # Update SCG table where course_id and student_id, with group_id
    # The following command didn't work, don't know why...
    #Scg.update( update_info.keys, update_info.values )


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
  
  def start_sort
  
  end
  
end
