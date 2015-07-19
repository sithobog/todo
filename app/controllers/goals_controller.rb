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
  	@goal = @user.goals.create(goal_params)

  	if @goal.save
  		redirect_to user_goal_path(@user,@goal)
  	else
  		render 'new'
  	end
  end



  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_goal_path(@user,@goal)
    else
      render 'edit'
    end
  end


  def destroy
    @goal = @user.goals.find(params[:id])
    @goal.destroy
    redirect_to user_goals_path(@user)
  end


  private

  def goal_params
  	params.require(:goal).permit(:name,:description,:term,:image)
  end

  def get_user
    @user = current_user
  end

end
