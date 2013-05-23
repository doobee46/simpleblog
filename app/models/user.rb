class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

    validates :email, :uniqueness => true,
				  :length => { :within => 5..50 },
				  :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
	validates :password, :confirmation => true,
						 :length => { :within => 4..20 },
						 :presence => true
						 
	 
	has_one :profile
	has_many :articles, :order => 'published_at DESC, title ASC',
	:dependent => :nullify
	has_many :replies, :through => :articles, :source => :comments

	def datereg
	  created_at.to_formatted_s(:long)
	end
	 
end
