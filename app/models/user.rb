class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy 
  has_many :votes, dependent: :destroy
  after_destroy :ensure_an_admin_remains
  before_destroy :cannot_delete_admin
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  # paper clip validations and defaults
  has_attached_file :avatar, 
  :styles => { medium: "150x 150>", thumb:"50x50>" }, 
  :default_url => "/assets/rename.png",
  :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
  :url => "/system/:attachment/:id/:style/:filename"
  
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  def toggle_active_status
    self.is_active ? self.update(:is_active => false) : self.update(:is_active => true)
  end

private
	def ensure_an_admin_remains
		if User.count.zero?
			raise "Can't delete last user"
		end
	end

  def cannot_delete_admin
    if self.is_admin?
      raise "Can't delete admin user"
    end
  end
end
