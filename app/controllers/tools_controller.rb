class ToolsController < ApplicationController

  before_action :get_goal

  def index
    @tools = @goal.tools
  end

  def show
    @tool = @goal.tools.find(params[:id])
  end

  def new
    @tool = @goal.tools.new
  end

  def edit
    @tool = @goal.tools.find(params[:id])
  end

  def create
    @tool = @goal.tools.build(tool_params)
    if owner?
      if @tool.save
        redirect_to user_goal_tools_path(@user, @goal), notice: my_notice
      else
        render 'new'
      end
    else
      redirect_to user_goal_tools_path(@user, @goal), alert: my_alert
    end
  end

  def update
    @tool = Tool.find(params[:id])
    if owner?
      @tool.update(tool_params)
      redirect_to user_goal_tools_path(@user, @goal), notice: my_notice
    else
      redirect_to user_goal_tools_path(@user, @goal), alert: my_alert
    end
  end

  def destroy
    @tool = @goal.tools.find(params[:id])
    if owner?
      @tool.destroy
      redirect_to user_goal_tools_path(@user, @goal), notice: my_notice
    else
      redirect_to user_goal_tools_path(@user, @goal), alert: my_alert
    end
  end

  private
  
  def get_user
    @user = User.find(params[:user_id])
  end

  def get_goal
    get_user
    @goal = Goal.find(params[:goal_id])
  end

  def tool_params
    params.require(:tool).permit(:description)
  end

end
