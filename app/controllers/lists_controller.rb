class ListsController < ApplicationController

  before_action :get_user
  helper_method :find_goal

  def index
    @lists = @user.lists
  end

  def create
    @list = @user.lists.build(list_params)
    if owner?
      redirect_to user_list_path(@user, @list) if @list.save
    else
      redirect_to user_calendar_path(@user), alert: my_alert
    end
  end

  def show
    get_goals
    completed?
    @list = @user.lists.includes(:tasks).find(params[:id])
  end

  def destroy
    @list = @user.lists.find(params[:id])
    if owner?
      @list.destroy
      redirect_to user_lists_path(@user), notice: my_notice
    else
      redirect_to user_lists_path(@user), alert: my_alert
    end
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
    if status_array.empty?
      flag = false
    else
      status_array.each do |status|
        flag = false if status == "active" 
      end
    end
    flag ? complete : active
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
    @goals = @user.goals.includes(:tools)
  end

  def list_params
    params.permit(:list_date)
  end
end
