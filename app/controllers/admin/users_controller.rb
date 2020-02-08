class Admin::UsersController < ApplicationController
  before_action :require_admin
  skip_before_action :verify_authenticity_token


  def index
    @users = User.all    
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    # if 
    #   redirect_to admin_user_path(@user)
    # else
    #   render :new
    # end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image,:admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to login_path unless current_user.admin? 
  end
end
