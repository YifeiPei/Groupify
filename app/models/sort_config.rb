class SortConfig < ActiveRecord::Base
	belongs_to :course
	validates :group_size, presence: true, numericality: { only_integer: true }
end
