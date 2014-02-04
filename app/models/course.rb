class Course < ActiveRecord::Base
	belongs_to :user
	has_many :groups
  	has_many :students, through: :groups
	has_one :sort_config
end
