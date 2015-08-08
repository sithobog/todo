class TasksController < ApplicationController

	before_action :get_list

  def edit
    @task = @list.tasks.find(params[:id])
  end

  def create
  	@task = @list.tasks.create(task_params)

  	if @task.save
  		redirect_to user_list_path(@user,@list)
  	else
  		render 'new'
  	end
  end

  def destroy
    @task = @list.tasks.find(params[:id])
    @task.destroy
    redirect_to user_list_path(@user,@list), notice: "Task successfully deleted"
  end

  def sort
    params[:order].each do |key,value|
      @list.tasks.find(value[:id]).update_attribute(:priority,value[:position])
    end
    render :nothing => true
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
    params.require(:task).permit(:description)
  end

end
