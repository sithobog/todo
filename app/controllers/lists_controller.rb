class ListsController < ApplicationController

  before_action :get_user
  helper_method :find_goal

  def index
    @lists = @user.lists
  end

  def create
  	@list = @user.lists.create(list_params)
    redirect_to user_list_path(@user, @list) if @list.save
  end

  def show
    get_goals
    completed?
		@list = @user.lists.find(params[:id])
  end

  def destroy
    @list = @user.lists.find(params[:id])
    @list.destroy
    redirect_to user_lists_path(@user), notice: "List successfully deleted"
  end

  def find_goal(goal_id)
    @goal = Goal.find_by(id: goal_id)
  end

  private
  def get_user
    @user = User.find(params[:user_id])
  end

  def completed?
    @list = @user.lists.find(params[:id])
    flag = true
    status_array = @list.tasks.pluck(:status)
    status_array.each do |status|
      if status == "active"
        flag = false
      end
    end
    if flag == true
      complete
    else
      active
    end
  end

  def complete
    @list.status = "completed"
    @list.save
  end

  def active
    @list.status = "active"
    @list.save
  end

  def get_goals
    get_user
    @goals = @user.goals
  end

  def list_params
    params.permit(:list_date)
  end
end
