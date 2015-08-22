class Tool < ActiveRecord::Base 
  belongs_to :goal
  validates :description, presence: true, length: {minimum: 5}
end
