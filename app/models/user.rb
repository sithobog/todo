class User < ActiveRecord::Base
  validates :name, presence: true,
                    length: {minimum: 5},
                    uniqueness: true
  has_many :goals, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :tasks, through: :lists
  has_one :calendar, dependent: :destroy
  has_one :diary, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
  default_url: "missing_:style.png"

  
	validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 2.megabytes								 
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
