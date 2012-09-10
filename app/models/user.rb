class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  def self.authenticate_email(email, password)
		if user = self.find_by_email(email)
			# raise "user found!"
			curr_user = self.find_by_email(email)

	     	if curr_user.hashed_password == encrypt_password(password, curr_user.salt)
				return curr_user
	    	else
				return nil
	     	end
		end
	end

  def self.encrypt_password(password, salt)
		Digest::SHA2.hexdigest(password + "wibble" + salt)
	end

end
