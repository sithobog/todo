class GoalsController < ApplicationController

  before_action :authenticate_user!, :get_user
  helper_method :goals_owner?

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
  	@goal = @user.goals.create(goal_params)

  	if @goal.save
  		redirect_to user_goal_path(@user, @goal)
  	else
  		render 'new'
  	end
  end

  def update
    @goal = Goal.find(params[:id])
    if goals_owner?
      @goal.update(goal_params)
      redirect_to user_goal_path(@user, @goal), notice: "Goal successfully updated"
    else
      redirect_to user_goal_path(@user, @goal), alert: "You do not have permission to modify goal"
    end
  end

  def destroy
    @goal = @user.goals.find(params[:id])
    if goals_owner?
      @goal.destroy
      redirect_to user_goals_path(@user), notice: "Goal successfully deleted"
    else
      redirect_to user_goal_path(@user, @goal), alert: "You do not have permission to delete goal"
    end
  end

  def goals_owner?
    @user == current_user
  end

  private

  def goal_params
  	params.require(:goal).permit(:name,:description,:term,:image)
  end

  def get_user
    @user = User.find(params[:user_id])
  end

end
