class Group < ActiveRecord::Base
	has_many :scgs, autosave: true
  	has_many :students, through: :scgs
end
