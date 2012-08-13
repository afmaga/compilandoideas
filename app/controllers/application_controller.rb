class ApplicationController < ActionController::Base
  protect_from_forgery


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
	def authorize_admin

			if session[:role] != "admin"

				redirect_to url_for(:controller => "application", :action => "index"), :alert => _("User permissions required") and return 1
			end

	end
	def authorize
		session[:return_to] = request.fullpath

		#@array =  ApplicationController.get_models
		#@array.each do |a|
		#	logger.info a
		#end

		unless User.find_by_id(session[:user_id])
			redirect_to login_url, :alert => "Please log in" and return 1


		end
	end

end