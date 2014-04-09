class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :define_categories

  def set_user
		if session && session[:user_id]
			@logged_user = User.find_by_id(session[:user_id])

			if @logged_user && @logged_user.language && !session[:lang]
				FastGettext.locale = @logged_user.language
			end
		end

		params[:lang] = FastGettext.locale
	end

  def index    
    
  end

  protected

  def define_categories
    @categories = Category.all
  end

	def authorize_admin

			if session[:role] != "admin"

				redirect_to welcome_url, :alert => _("User permissions required") and return 1
			end

	end

	def authorize
		session[:return_to] = request.fullpath
	
		unless User.find_by_id(session[:user_id])
			redirect_to login_url, :alert => "Please log in" and return 1

		end
	end

end