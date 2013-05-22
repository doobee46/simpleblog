require 'bcrypt'
class User < ActiveRecord::Base
attr_accessible :email, :password, :password_confirmation

attr_accessor :password
before_save :encrypt_password

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
 
def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
end

protected
 
def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
end


end





