require 'csv'

class GroupedController < LecturerApplicationController
  layout 'lecturer_application'
  def index
    @start_column = 1 # only display the first two headers
    @end_column = 2
    @current_course = Course.find(session[:course_id])

    # Load csv file and create list of students
    @student_list = []
    @groups = 0
    i = 0
    CSV.foreach("#{Rails.root}/uploads/STEM-sorted.csv") do |row|
      if i == 0
        @header = row
        i = 1
      else
        if @student_list[row[-1].to_i - 1] == nil
          @student_list[row[-1].to_i - 1] = []
        end

        @student_list[row[-1].to_i - 1] << row

        if row[-1].to_i > @groups
          @groups = row[-1].to_i
        end
      end
    end
  end
end
