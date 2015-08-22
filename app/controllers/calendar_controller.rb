class CalendarController < ApplicationController

  before_action :authenticate_user!, :user_goals, :get_user

  
  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def user_goals
    get_user
    @goals = @user.goals
  end

  private
  
  def get_user
    @user = User.find(params[:user_id])
  end

end
