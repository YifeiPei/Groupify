class Group < ActiveRecord::Base
	has_many :scgs, autosave: true
end
