class Task < ActiveRecord::Base
  belongs_to :list, touch: true
  validates :description, presence: true, length: {minimum: 5}
  default_scope { order("priority ASC") }
end
