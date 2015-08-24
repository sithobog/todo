class TasksController < ApplicationController

  before_action :get_list
  respond_to :html, :js, only: [:destroy, :create, :generate]
  helper_method :find_goal

  def edit
    @task = @list.tasks.find(params[:id])
  end

  def create
    @task = @list.tasks.build(task_params)
    if owner?
      @task.save
    else
      redirect_to user_list_path(@user,@list), alert: my_alert
    end
  end

  def destroy
    @task = @list.tasks.find(params[:id])
    if owner?
      @task.destroy
    else
      redirect_to user_list_path(@user,@list), alert: my_alert
    end
  end

  #this action create task from goal's tool
  def generate
    @task = @list.tasks.build(task_tool_params)
    @task.save
  end

  def complete
    @task = @list.tasks.find(params[:task_id])
    @task.status = "completed"
    @task.save
    render :nothing => true
  end

  def sort
    params[:order].each do |key,value|
      @list.tasks.find(value[:id]).update_attribute(:priority,value[:position])
    end
    render :nothing => true
  end

  def find_goal(goal_id)
    @goal = Goal.find_by(id: goal_id)
  end

  private
  
  def get_user
    @user = User.find(params[:user_id])
  end

  def get_list
    get_user
    @list = List.find(params[:list_id])
  end

  def task_params
    params.require(:task).permit(:description, :goal_id)
  end

  def task_tool_params
    params.permit(:description, :list_id, :goal_id)
  end

end
