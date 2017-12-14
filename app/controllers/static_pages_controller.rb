class StaticPagesController < ApplicationController
  def home

  	if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: session[:user_id])	
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
  	if @current_user.nil? 
		redirect_to login_path
	else 
	end 		
  end
end
