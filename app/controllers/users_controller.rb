class UsersController < ApplicationController

  before_action :authenticate_user!
  helper_method :owner?

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
      @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile successfully updated"
    elsif owner? == false
      redirect_to user_path(@user), alert: "You do not have permission to modify profile"
    else
      render 'edit'
    end
  end 

  def destroy
    @user = User.find(params[:id])
    if owner?
      @user.destroy
      redirect_to root_path, notice: "Profile successfully deleted"
    else
      redirect_to user_path(@user), alert: "You do not have permission to delete profile"
    end
  end


  def owner?
    @user = User.find(params[:id])
    @user == current_user
  end


  private
    def user_params
      params.require(:user).permit(:name, :avatar)
    end

end
