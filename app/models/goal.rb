class Goal < ActiveRecord::Base

  belongs_to :user

  scope :id_order, -> { order(id: :asc) }
  
end
