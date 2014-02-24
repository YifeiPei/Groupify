#!/usr/bin/env ruby

require 'csv'

module Grouper

	class Random_sorter

		def initialize

		end

		def sort( student_list, group_size )
			# Check that student_list is array
			unless student_list.kind_of?(Array)
				return
			else	
			# Check that each element is a hash

				total_students = student_list.length
				number_of_groups = total_students / group_size.to_i

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

  				i = 0
  				student_list.map! do |student|
  					if student.kind_of?(Hash)
  						student['group_number'] = group_numbers[i][1]
  					elsif student.kind_of?(Array)
  						student << group_numbers[i][1]
            elsif student.respond_to?(:group_number)
              student.group_number = group_numbers[i][1]
  					end
  					i = i +1
  					student
  				end
  				student_list
			end
		end	

		def get_student_list_from_csv( filename )
			student_list = CSV.read( filename )
		end

		def get_student_list_from_db( course_id )
			student_list = Student.where(course_id: course_id)
		end

		def write_group_numbers_to_db( sorted_list )
			sorted_list.save
      #sorted_list.each do |student|
			#	Student.where(student_id: student['student_id']).update_all(group_number: student['group_number'])
			#end
		end

		def write_group_numbers_to_csv( sorted_list, filename )
			CSV.open( filename, "wb" ) do |csv|
				sorted_list.each do |student|
					csv << student
				end
			end	
		end

		def hello
			'hello'
		end
	end
end	
