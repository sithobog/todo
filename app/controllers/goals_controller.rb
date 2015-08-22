class GoalsController < ApplicationController

  before_action :authenticate_user!, :get_user

  def index
    @goals = @user.goals
  end

  def show
    @goal = @user.goals.find(params[:id])
  end

  def new
    @goal = @user.goals.new
  end

  def edit
    @goal = @user.goals.find(params[:id])
  end

  def create
    @goal = @user.goals.build(goal_params)
    if owner?
      if @goal.save
        redirect_to user_goal_path(@user, @goal), notice: my_notice
      else
        render 'new'
      end
    else
      redirect_to user_goals_path(@user), alert: my_alert
    end
  end

  def update
    @goal = Goal.find(params[:id])
    if owner?
      if @goal.update(goal_params)
        redirect_to user_goal_path(@user, @goal), notice: my_notice
      else
        render 'edit'
      end
    else
      redirect_to user_goals_path(@user, @goal), alert: my_alert
    end
  end

  def destroy
    @goal = @user.goals.find(params[:id])
    if owner?
      @goal.destroy
      redirect_to user_goals_path(@user), notice: my_notice
    else
      redirect_to user_goals_path(@user), alert: my_alert
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:name,:description,:term,:image, :conclusion, :status)
  end

  def get_user
    @user = User.find(params[:user_id])
  end

end
