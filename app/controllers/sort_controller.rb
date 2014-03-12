require 'Grouper'

class SortController < ApplicationController
  layout 'lecturer_application'
  
  def index
    @current_course = Course.find_by(id: session[:course_id])
    @sort = {}
  end

  def sort
    # Check if course is already grouped
	
    @current_course = Course.find_by(id: session[:course_id])
	if @current_course.grouped
		Group.destroy_all(:course_id => session[:course_id])
   	 	Scg.where(:course_id => session[:course_id]).update_all(group_id: nil)		
	end
	
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
    
    course = Course.find_by(id: session[:course_id])
    # Get student list from db
    student_list = sorter.get_student_list_from_db( session[:course_id] )
    
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
        group.course_id = course.id
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

	student.group_id = group.id
	student.save
    scg.group_id = group.id
    scg.save

    #update_info[scg.id] = item
    end
    # Update SCG table where course_id and student_id, with group_id
    # The following command didn't work, don't know why...
    #Scg.update( update_info.keys, update_info.values )

    course.grouped = true
    course.save

    redirect_to '/grouped'
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
   	 SortConfig.where(:course_id => session[:course_id]).update_all(course_id: session[:course_id], group_size: params[:group_size], algorithm: params[:algorithm], age: params[:age], gpa: params[:gpa], degree: params[:degree])
    end
    # Run sort algorithm
    advanced_sort
  end
  
  ########## This is our latest algorithm ##########
  
   def advanced_sort
      # Check if course is already grouped	
    @current_course = Course.find_by(id: session[:course_id])
	if @current_course.grouped
		Group.destroy_all(:course_id => session[:course_id])
   	 	Scg.where(:course_id => session[:course_id]).update_all(group_id: nil)		
   	 	Student.where(:course_id => session[:course_id]).update_all(group_id: nil)		
	end
	@existing_config = SortConfig.find_by(course_id: session[:course_id])
  	if @existing_config.blank?
      redirect_to '/sort/index'
    end
    
#####  Data preparation ##########

  @student_list = Student.find(:all, :order => "degree", :conditions => {:course_id => session[:course_id]} )
    # Set parameters
    group_size = @existing_config.group_size
    # Find out number of students in course
    total_students = @student_list.count
    # Calculate number of groups
    number_of_groups = total_students / group_size
    # Create new groups in groups table
    groups = []	
    for count in 0...number_of_groups do
      groups << Group.new do |group|
        group.number = count + 1
        group.course_id = session[:course_id]
      end
      groups[count].save
    end	
    #check the number of same degree for different degree

	@student_new_list = Hash.new
	@student_list.each do |each_student|
		if @student_new_list[each_student.degree].blank?
			@student_new_list[each_student.degree] = []
			@student_new_list[each_student.degree] << each_student.id
		else
			@student_new_list[each_student.degree] << each_student.id
		end
	end
	@student_new_list = Hash[@student_new_list.sort_by {|k,v,c| v.length}.reverse]
	@group_list = Group.find(:all, :order => "id", :conditions => {:course_id => session[:course_id]})	
	save_point = -1
	grouped_count = 0
###### Start Sorting #######
	##
	##	every new round of each degree, start from a save point which store the last group id that previous degree finish at
	##
	# get each value in hash
	@student_new_list.each do |key, student_list_by_degree|
		student_list_by_degree = student_list_by_degree.shuffle
		# stop when no student in the list 
		while !student_list_by_degree.empty? do	
			# get groups to put the student in				
			@group_list.each do |each_group|
				# ignore the groups that before the save point
					if each_group.id > save_point || save_point == @group_list[-1].id
					# ignore the groups that is full, unless we have reminder
					if Student.where(course_id: session[:course_id], group_id: each_group.id).count == group_size
						if grouped_count < number_of_groups
							next
						end
					elsif Student.where(course_id: session[:course_id], group_id: each_group.id).count > group_size
						next
					end
					save_point = -1
					each_student_id = student_list_by_degree.shift
					@current_student_id = each_student_id	 
   	 				Scg.where(:course_id => session[:course_id], :student_id => @current_student_id).update_all(group_id: each_group.id)		
   	 				Student.where(:id => @current_student_id).update_all(group_id: each_group.id)			
					# save save_point if the current degree list finishes
					if Student.where(course_id: session[:course_id], group_id: each_group.id).count == group_size
						grouped_count += 1
					end
					if student_list_by_degree.empty?
						save_point = each_group.id
						break
					end
				else
					next
				end
			end
		end
	end
##### redirect  #########	
    redirect_to '/grouped'	
	end
 
  
  
############  buggy one   ############
  
   def buggy_sort
      # Check if course is already grouped	
    @current_course = Course.find_by(id: session[:course_id])
	if @current_course.grouped
		Group.destroy_all(:course_id => session[:course_id])
   	 	Scg.where(:course_id => session[:course_id]).update_all(group_id: nil)		
   	 	Student.where(:course_id => session[:course_id]).update_all(group_id: nil)		
	end
	@existing_config = SortConfig.find_by(course_id: session[:course_id])
  	if @existing_config.blank?
      redirect_to '/sort/index'
    end
    
#####  Data preparation ##########

  @student_list = Student.find(:all, :order => "degree", :conditions => {:course_id => session[:course_id]} )
    # Set parameters
    group_size = @existing_config.group_size
    # Find out number of students in course
    total_students = @student_list.count
    # Calculate number of groups
    number_of_groups = total_students / group_size
    reminder = total_students % group_size
    # Create new groups in groups table
    groups = []	
    for count in 0...number_of_groups do
      groups << Group.new do |group|
        group.number = count + 1
        group.course_id = session[:course_id]
      end
      groups[count].save
    end	
    #check the number of same degree for different degree

	@student_new_list = Hash.new
	@student_list.each do |each_student|
		if @student_new_list[each_student.degree].blank?
			@student_new_list[each_student.degree] = []
			@student_new_list[each_student.degree] << each_student.id
		else
			@student_new_list[each_student.degree] << each_student.id
		end
	end
	@student_new_list = Hash[@student_new_list.sort_by {|k,v,c| v.length}.reverse]
	@group_list = Group.find(:all, :order => "id", :conditions => {:course_id => session[:course_id]})	

	stop_point = 0
###### Start Sorting #######
	@student_new_list.each do |key, student_list_by_degree|
		if student_list_by_degree.length > number_of_groups
			over = true
			diff = student_list_by_degree.length 
			while diff > number_of_groups do
				diff -= number_of_groups
			end
		else
			over = false
			diff = -1
			stop_point = -1
		end	
		while !student_list_by_degree.empty? do	
			@group_list.each do |each_group|
				if over == true && student_list_by_degree.length <= diff && each_group.id < stop_point
					next	
				elsif each_group.id > stop_point
					if Student.where(course_id: session[:course_id], group_id: each_group.id).count == group_size
						if reminder > 0
							if each_group.id > stop_point
								stop_point = -1
								diff = -1
							end
							reminder = reminder - 1
						else
							next
						end
					elsif Student.where(course_id: session[:course_id], group_id: each_group.id).count > group_size
						next
					end
				end
				each_student_id = student_list_by_degree.shift
				@current_student_id = each_student_id	 
   	 			Scg.where(:course_id => session[:course_id], :student_id => @current_student_id).update_all(group_id: each_group.id)		
   	 			Student.where(:id => @current_student_id).update_all(group_id: each_group.id)			
				if student_list_by_degree.empty? && over == true
					stop_point = each_group.id
				end
			end
		end
	end
##### redirect  #########	
    redirect_to '/grouped'
	
end

  
  
  
  
  
  ##########  shitty one just ignore ####################
  
  
  def shitty_sort
      # Check if course is already grouped	
    @current_course = Course.find_by(id: session[:course_id])
	if @current_course.grouped
		Group.destroy_all(:course_id => session[:course_id])
   	 	Scg.where(:course_id => session[:course_id]).update_all(group_id: nil)		
   	 	Student.where(:course_id => session[:course_id]).update_all(group_id: nil)		
	end
	@existing_config = SortConfig.find_by(course_id: session[:course_id])
  	if @existing_config.blank?
      redirect_to '/sort/index'
    end
    
#####  Data preparation ##########

  @student_list = Student.find(:all, :order => "degree", :conditions => {:course_id => session[:course_id]} )
    # Set parameters
    group_size = @existing_config.group_size
    # Find out number of students in course
    total_students = @student_list.count
    # Calculate number of groups
    number_of_groups = total_students / group_size
    reminder = total_students % group_size
    # Create new groups in groups table
    groups = []	
    for count in 0...number_of_groups do
      groups << Group.new do |group|
        group.number = count + 1
        group.course_id = session[:course_id]
      end
      groups[count].save
    end	
    #check the number of same degree for different degree

	@student_new_list = Hash.new
	@student_list.each do |each_student|
		if @student_new_list[each_student.degree].blank?
			@student_new_list[each_student.degree] = []
			@student_new_list[each_student.degree] << each_student.id
		else
			@student_new_list[each_student.degree] << each_student.id
		end
	end
	@student_new_list = Hash[@student_new_list.sort_by {|k,v,c| v.length}.reverse]
	@group_list = Group.find(:all, :conditions => {:course_id => session[:course_id]})	

###### Start Sorting #######
while !@student_new_list.empty?  do
	@student_new_list.each do |key, student_list_by_degree|
		@group_list.each do |each_group|
			if Student.where(course_id: session[:course_id], group_id: each_group.id).count == group_size
				if reminder > 0
					reminder = reminder - 1
				else
					next
				end
			end
			@current_student_id = student_list_by_degree.shift	 
   	 		Scg.where(:course_id => session[:course_id], :student_id => @current_student_id).update_all(group_id: each_group.id)		
   	 		Student.where(:id => @current_student_id).update_all(group_id: each_group.id)			
		end
		if student_list_by_degree.empty?
			@student_new_list.delete(key)
		end
	end
	@student_new_list = Hash[@student_new_list.sort_by {|k,v,c| v.length}.reverse]
	@group_list = @group_list.reverse
	end
##### Store Results #########
	
    redirect_to '/grouped'
	
  end
end
