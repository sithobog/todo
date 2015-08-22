class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
  end  

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
      
  def update
    @user = User.find(params[:id])
    if owner?
      if @user.update(user_params)
        redirect_to user_path(@user), notice: my_notice("profile")
      else
        render 'edit'
      end
    else
      redirect_to user_path(@user), alert: my_alert("profile")
    end
  end 

  def destroy
    @user = User.find(params[:id])
    if owner?
      @user.destroy
      redirect_to root_path, notice: my_notice("profile")
    else
      redirect_to user_path(@user), alert: my_alert("profile")
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
