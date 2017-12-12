class UsersController < ApplicationController
  def show
    if current_user.id.to_s == params[:id]
  	  @user = User.find(params[:id])
    else
      redirect_to posts_path
    end
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		flash[:success] = "Bienvenido a Paycesa"
      login_url(@user)
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Perfil creado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
