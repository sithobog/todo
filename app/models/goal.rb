class Goal < ActiveRecord::Base
	validates :name, presence: true,
					length: {minimum: 5},
					uniqueness: true
	validates :description, presence: true
	validates :term, presence: true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :xs => "30x30>" },
  default_url: "missing_:style.png"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  has_many :tools, dependent: :destroy
  has_many :tasks, dependent: :destroy


  scope :id_order, -> { order(id: :asc) }
  scope :goal_id, -> (goal_id) { where id: goal_id}
  
end
