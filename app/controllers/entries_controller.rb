class EntriesController < ApplicationController

  before_action :get_user
  helper_method :find_goal

	def index
  	@entries = @user.entries
  end

  def show
    get_tasks_for_goals_from_list
  end

  def new
    @entry = @user.entries.new
  end

  def edit
    @entry = @user.entries.find(params[:id])
  end

  def create
  	@entry = @user.entries.create(entry_params)

  	if @entry.save
  		redirect_to user_entry_path(@user, @entry)
  	else
  		render 'new'
  	end
  end

  def update
    @entry = entry.find(params[:id])
    @entry.update(entry_params)
    redirect_to user_entry_path(@user, @entry), notice: "entry successfully updated"
  end

  def destroy
    @entry = @user.entries.find(params[:id])
    @entry.destroy
    redirect_to user_entries_path(@user), notice: "entry successfully deleted"
  end

  def find_goal(goal_id)
    @goal = Goal.find_by(id: goal_id)
  end

  private
  
  def entry_params
    params.require(:entry).permit(:body, :day)
  end

  def get_tasks_for_goals_from_list
    @entry = @user.entries.find(params[:id])
    @list = @user.lists.find_by(list_date: @entry.day)
    @tasks = @list.tasks.where(status: 'completed').where.not(goal_id: nil) if @list
  end

  def get_user
    @user = User.find(params[:user_id])
  end

end
