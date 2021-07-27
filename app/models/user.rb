class User < ActiveRecord::Base
  has_secure_password
  
  validates :password, length: {minimum: 7} 

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :first_name, presence: true

  validates :last_name, presence: true
  
  auto_strip_attributes :email, virtual: true

  before_save { email.downcase! }
  
  def self.authenticate_with_credentials(email, password)
   email.strip!
   puts "email before: #{email}"
   email.downcase!
   puts "email after: #{email}"
    user = User.find_by_email(email)
   
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
  