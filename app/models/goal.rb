class Goal < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
  default_url: "missing_:style.png"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  scope :id_order, -> { order(id: :asc) }
  
end
