class ListsController < ApplicationController

  before_action :get_user

  def index
    @lists = @user.lists
  end

  def create
  	@list = @user.lists.create(list_params)
    redirect_to user_list_path(@user, @list) if @list.save
  end

  def show
		@list = @user.lists.find(params[:id])
  end


  def destroy
    @list = @user.lists.find(params[:id])
    @list.destroy
    redirect_to user_lists_path(@user), notice: "List successfully deleted"
  end

  private
  def get_user
    @user = User.find(params[:user_id])
  end

  def list_params
    params.permit(:list_date)
  end
end
