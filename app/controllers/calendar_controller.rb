class CalendarController < ApplicationController

  before_action :authenticate_user!, :user_goals, :get_user

  
  def show
  	@date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  #def goals_for_user
  	#get_user
  	#@goals_by_date = @user.goals.group_by(&:term)
  	#@goals_by_date = @user.goals
  #end

  def user_goals
  	get_user
  	@goals = @user.goals
  end

  #def goals_by_date
  	#get_user
  	#@goals_by_date = @user.goals.group_by(&:term)
  #end

  private
  def get_user
    @user = User.find(params[:user_id])
  end

end
