class Tool < ActiveRecord::Base

	belongs_to :goal

  validates :description, presence: true
end
