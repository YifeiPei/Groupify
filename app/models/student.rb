class Student < ActiveRecord::Base
	has_many :groups
  	has_many :courses, through: :groups
end
