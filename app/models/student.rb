require 'csv'
class Student < ActiveRecord::Base
	has_many :scgs, autosave: true
  	has_many :courses, through: :scgs
  	
  def self.import(file,course_id)
  spreadsheet = open_spreadsheet(file)
#  header = spreadsheet.row(1)
  (1..spreadsheet.last_row).each do |i|
    row = spreadsheet.row(i)
    student = find_by(:student_id => row[0], :course_id => course_id) || new
    student.student_id = row[0]
    student.first_name = row[1]
    student.last_name = row[2]
    student.degree = row[3]
    student.course_id = course_id
    student.email = "#{student.student_id}@student.adelaide.edu.au"
   student.save!
  end
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Roo::Csv.new(file.path)
  when ".xls" then Roo::Excel.new(file.path)
  when ".xlsx" then Roo::Excelx.new(file.path)
  else raise "Unknown file type: #{file.original_filename}"
  end
end
end
