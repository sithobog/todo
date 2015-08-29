class Task < ActiveRecord::Base
  belongs_to :list, touch: true
  validates :description, presence: true
  default_scope { order("priority ASC") }
end
