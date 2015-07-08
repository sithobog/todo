class GoalsController < ApplicationController
  def index
  	@goals = Goal.all
  end

  def show
  	@goal = Goal.find(params[:id])
  end

  def new
  	@goal = Goal.new
  end

  def create
  	@goal = Goal.new(goal_params)

  	if @goal.save
  		redirect_to @goal
  	else
  		render 'new'
  	end
  end

  def edit
  	@goal = Goal.find(params[:id])
  	
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to @goal
    else
      render 'edit'
    end
   end



  private

  def goal_params
  	params.require(:goal).permit(:name,:description,:term)
  end

end
