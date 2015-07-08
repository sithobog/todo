class Goal < ActiveRecord::Base
	scope :id_order, -> { order(id: :asc) }
end
