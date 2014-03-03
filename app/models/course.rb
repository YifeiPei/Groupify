class Course < ActiveRecord::Base
	belongs_to :user
	has_many :scgs, autosave: true
  	has_many :students, through: :scgs
	has_one :sort_config, autosave: true
	
	validates :name, presence: true
end
