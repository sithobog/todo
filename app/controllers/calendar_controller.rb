class CalendarController < ApplicationController

  before_action :authenticate_user!, :user_goals
  helper_method :check_list
  
  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    check_list
  end

  private
  
  def get_user
    @user = User.find(params[:user_id])
  end

  def user_goals
    get_user
    @goals = @user.goals
  end

  def check_list
    @hash = Hash.new
    @lists = @user.lists
    @lists.each do |list|
      if @date.month == list.list_date.month && @date.year == list.list_date.year
        @hash[list.id] = list.list_date
      end
    end
  end

end
