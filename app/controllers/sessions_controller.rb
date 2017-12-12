class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:sessions][:email])
  	if user && user.authenticate(params[:sessions][:password])
  		session[:user_id] = user.id
      if params[:sessions][:remember_me] == "1" 
        remember(user) 
      else

  		  user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token) 
      end
      redirect_to root_path
  	else
  		flash[:danger] = "Invalid email or password"
  		redirect_to root_path	
  	end

  end

  def destroy
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id]) 
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    if !@current_user.nil? 
      @current_user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token) 
      session.delete(:user_id)
      @current_user = nil 
    end 
  	#log_out if logged_in?
    redirect_to root_url
  end
end
