class Course < ActiveRecord::Base
	belongs_to :user
	has_many :scgs
  	has_many :students, through: :scgs
	has_one :sort_config
end
