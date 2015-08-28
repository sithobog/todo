class Tool < ActiveRecord::Base 
  belongs_to :goal, touch: true
  validates :description, presence: true, length: {minimum: 5}
end
