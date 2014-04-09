class User < ActiveRecord::Base
  has_and_belongs_to_many :posts, :class_name => 'post', :foreign_key => 'author_id'
  has_and_belongs_to_many :comments, :class_name => 'comment', :foreign_key => 'author_id'
  validates :name, :presence => true, :uniqueness => true, :unless => :force_submit
	validates :email, :presence => true, :uniqueness => true, :unless => :force_submit
	validate  :password_must_be_present	, :unless => :force_submit
	validates :password, :confirmation => true, :unless => :force_submit

	attr_accessor :force_submit
	attr_accessor :password_confirmation
	attr_reader   :password
  
  def self.authenticate_email(email, password)
		if user = self.find_by_email(email)
			
			user = self.find_by_email(email)

	     	if user.active && user.hashed_password == encrypt_password(password, user.salt)
          return user
	    	else
          return nil
	     	end
		end
	end

  def self.encrypt_password(password, salt)
		Digest::SHA2.hexdigest(password + "wibble" + salt)
	end

	def password=(password)
		@password = password

		if password.present?
			generate_salt

			self.hashed_password = self.class.encrypt_password(password, self.salt)
		end
	end

  private

	def password_must_be_present
		errors.add(:password, "Missing password") unless hashed_password.present?
	end

	def generate_salt
		self.salt = self.object_id.to_s + rand.to_s
	end

  def self.get_if_session(sesion)
		if(User.find_by_id(sesion))
			return true
		else
			return false

		end
	end


end
